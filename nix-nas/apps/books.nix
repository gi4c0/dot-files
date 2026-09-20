{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  domain = "nixos.taila654ac.ts.net";
  bookLibrary = "/mnt/storage/books";

  # Backend ports, plain HTTP. E-ink readers usually can't run Tailscale,
  # so they reach these directly over the LAN.
  calibreWebPort = 8083;
  kosyncPort = 7200;

  # TLS ports behind nginx for clients on Tailscale (phone, browser).
  calibreWebTlsPort = 4535;
  kosyncTlsPort = 4536;
in
{
  # Calibre-Web: ebook library, web UI and OPDS catalog (KOReader browses
  # it via "OPDS Catalog", Readest via "Connect to Calibre-Web").
  services.calibre-web = {
    enable = true;

    listen = {
      ip = "0.0.0.0";
      port = calibreWebPort;
    };

    options = {
      calibreLibrary = bookLibrary;
      enableBookUploading = true;
      enableBookConversion = true;
    };
  };

  # Create an empty Calibre library on first boot so calibre-web can start.
  systemd.services.calibre-web-init-library = {
    description = "Create empty Calibre library if missing";
    requiredBy = [ "calibre-web.service" ];
    before = [ "calibre-web.service" ];
    serviceConfig = {
      Type = "oneshot";
      User = "calibre-web";
      Group = "calibre-web";
      StateDirectory = "calibre-web";
    };
    environment.HOME = "/var/lib/calibre-web";
    script = ''
      if [ ! -f ${bookLibrary}/metadata.db ]; then
        # calibredb restore_database is broken on calibre 9.x for empty
        # libraries (it unconditionally copies a non-existent .calnotes
        # dir), so create the library the same way the calibre GUI does.
        ${config.services.calibre-web.calibrePackage}/bin/calibre-debug -c \
          "from calibre.db.backend import DB; DB('${bookLibrary}', read_only=False)"
      fi
    '';
  };

  systemd.tmpfiles.settings."10-books"."${bookLibrary}".d = {
    user = "calibre-web";
    group = "calibre-web";
    mode = "0755";
  };

  # KOSync: reading-progress sync server for KOReader's built-in
  # "Progress sync" plugin and Readest's "KOReader sync".
  services.kosync = {
    enable = true;
    host = "0.0.0.0";
    port = kosyncPort;
  };

  networking.firewall.allowedTCPPorts = [
    calibreWebPort
    kosyncPort
  ];

  # Reverse proxy on separate TLS ports, reusing the Tailscale certificate.
  services.nginx.virtualHosts = {
    "calibre-web" = {
      serverName = domain;
      addSSL = true;

      listen = [
        {
          addr = "0.0.0.0";
          port = calibreWebTlsPort;
          ssl = true;
        }
      ];

      sslCertificate = "/var/lib/tailscale/certs/${domain}.crt";
      sslCertificateKey = "/var/lib/tailscale/certs/${domain}.key";

      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString calibreWebPort}";
      };
    };

    "kosync" = {
      serverName = domain;
      addSSL = true;

      listen = [
        {
          addr = "0.0.0.0";
          port = kosyncTlsPort;
          ssl = true;
        }
      ];

      sslCertificate = "/var/lib/tailscale/certs/${domain}.crt";
      sslCertificateKey = "/var/lib/tailscale/certs/${domain}.key";

      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString kosyncPort}";
      };
    };
  };
}
