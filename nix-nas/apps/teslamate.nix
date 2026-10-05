# TeslaMate: Tesla data logger + Grafana dashboards.
# No NixOS module exists for it, so it runs as three containers
# (PostgreSQL, TeslaMate app, Grafana) on a shared Docker network.
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  domain = "nixos.taila654ac.ts.net";
  teslamateTlsPort = 4537;
  grafanaTlsPort = 4538;
in
{
  # Env file (DATABASE/POSTGRES passwords, ENCRYPTION_KEY, GRAFANA_PASSWD)
  # rendered by sops-nix from secrets.yaml.
  sops.secrets."teslamate_env" = { };

  virtualisation.docker.enable = true;

  # Private network so the containers can resolve each other by name.
  systemd.services."docker-network-teslamate" = {
    description = "Create the teslamate docker network";
    after = [ "docker.service" ];
    requires = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      ${pkgs.docker}/bin/docker network inspect teslamate-net >/dev/null 2>&1 || \
        ${pkgs.docker}/bin/docker network create teslamate-net
    '';
  };

  systemd.tmpfiles.rules = [
    "d /mnt/storage/teslamate/postgres 0700 999 999 -"
    "d /mnt/storage/teslamate/grafana 0750 472 472 -"
  ];

  virtualisation.oci-containers = {
    backend = "docker";

    containers = {
      teslamate-database = {
        image = "postgres:17";
        autoStart = true;
        networks = [ "teslamate-net" ];
        environment = {
          POSTGRES_USER = "teslamate";
          POSTGRES_DB = "teslamate";
        };
        environmentFiles = [ config.sops.secrets."teslamate_env".path ];
        volumes = [
          "/mnt/storage/teslamate/postgres:/var/lib/postgresql/data"
        ];
      };

      teslamate-app = {
        image = "teslamate/teslamate:latest";
        autoStart = true;
        dependsOn = [ "teslamate-database" ];
        networks = [ "teslamate-net" ];
        environment = {
          TZ = "Europe/Lisbon";
          DISABLE_MQTT = "true";
        };
        environmentFiles = [ config.sops.secrets."teslamate_env".path ];
        ports = [ "127.0.0.1:4000:4000" ];
      };

      teslamate-grafana = {
        image = "teslamate/grafana:latest";
        autoStart = true;
        dependsOn = [ "teslamate-database" ];
        networks = [ "teslamate-net" ];
        environment = {
          TZ = "Europe/Lisbon";
          GF_SERVER_ROOT_URL = "https://${domain}:${toString grafanaTlsPort}";
        };
        environmentFiles = [ config.sops.secrets."teslamate_env".path ];
        volumes = [
          "/mnt/storage/teslamate/grafana:/var/lib/grafana"
        ];
        ports = [ "127.0.0.1:3000:3000" ];
      };
    };
  };

  # Make sure the network exists before any container starts.
  systemd.services."docker-teslamate-database".after = [ "docker-network-teslamate.service" ];
  systemd.services."docker-teslamate-database".requires = [ "docker-network-teslamate.service" ];
  systemd.services."docker-teslamate-app".after = [ "docker-network-teslamate.service" ];
  systemd.services."docker-teslamate-app".requires = [ "docker-network-teslamate.service" ];
  systemd.services."docker-teslamate-grafana".after = [ "docker-network-teslamate.service" ];
  systemd.services."docker-teslamate-grafana".requires = [ "docker-network-teslamate.service" ];

  # TeslaMate web UI: reverse proxy on a separate TLS port, reusing the
  # Tailscale certificate (same pattern as the other apps).
  services.nginx.virtualHosts."teslamate" = {
    serverName = domain;
    addSSL = true;

    listen = [
      {
        addr = "0.0.0.0";
        port = teslamateTlsPort;
        ssl = true;
      }
    ];

    sslCertificate = "/var/lib/tailscale/certs/${domain}.crt";
    sslCertificateKey = "/var/lib/tailscale/certs/${domain}.key";

    locations."/" = {
      proxyPass = "http://127.0.0.1:4000";
      proxyWebsockets = true;
      recommendedProxySettings = true;
    };
  };

  # Grafana dashboards: separate TLS port, same pattern.
  services.nginx.virtualHosts."teslamate-grafana" = {
    serverName = domain;
    addSSL = true;

    listen = [
      {
        addr = "0.0.0.0";
        port = grafanaTlsPort;
        ssl = true;
      }
    ];

    sslCertificate = "/var/lib/tailscale/certs/${domain}.crt";
    sslCertificateKey = "/var/lib/tailscale/certs/${domain}.key";

    locations."/" = {
      proxyPass = "http://127.0.0.1:3000";
      proxyWebsockets = true;
      recommendedProxySettings = true;
    };
  };
}
