{ pkgs, ... }: {
    programs.pgp = {
        enable = true;
        gpgAgent = {
            enable = true;
            enableSSHSupport = true;
        };
    };
}
    