{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    extraConfig = ''
        [manager]
        ratio          = [ 1, 4, 3 ]
        sort_by        = "alphabetical"
        sort_sensitive = false
        sort_reverse 	 = false
        sort_dir_first = true
        sort_translit  = false
        linemode       = "none"
        show_hidden    = false
        show_symlink   = true
        scrolloff      = 5
        mouse_events   = [ "click", "scroll" ]
        title_format   = "Yazi: {cwd}"

        [preview]
        wrap            = "no"
        tab_size        = 2
        max_width       = 600
        max_height      = 900
        cache_dir       = ""
        image_delay     = 30
        image_filter    = "triangle"
        image_quality   = 75
        sixel_fraction  = 15
        ueberzug_scale  = 1
        ueberzug_offset = [ 0, 0, 0, 0 ]

        [opener]
        edit = [
            { run = '${EDITOR:-vi} "$@"', desc = "$EDITOR", block = true, for = "unix" },
            { run = 'code %*',    orphan = true, desc = "code",           for = "windows" },
            { run = 'code -w %*', block = true,  desc = "code (block)",   for = "windows" },
        ]
        open = [
            { run = 'xdg-open "$1"',                desc = "Open", for = "linux" },
            { run = 'open "$@"',                    desc = "Open", for = "macos" },
            { run = 'start "" "%1"', orphan = true, desc = "Open", for = "windows" },
        ]
        reveal = [
            { run = 'xdg-open "$(dirname "$1")"',           desc = "Reveal", for = "linux" },
            { run = 'open -R "$1"',                         desc = "Reveal", for = "macos" },
            { run = 'explorer /select,"%1"', orphan = true, desc = "Reveal", for = "windows" },
            { run = '''exiftool "$1"; echo "Press enter to exit"; read _''', block = true, desc = "Show EXIF", for = "unix" },
        ]
        extract = [
            { run = 'ya pub extract --list "$@"', desc = "Extract here", for = "unix" },
            { run = 'ya pub extract --list %*',   desc = "Extract here", for = "windows" },
        ]
        play = [
            { run = 'mpv --force-window "$@"', orphan = true, for = "unix" },
            { run = 'mpv --force-window %*', orphan = true, for = "windows" },
            { run = '''mediainfo "$1"; echo "Press enter to exit"; read _''', block = true, desc = "Show media info", for = "unix" },
        ]

        [open]
        rules = [
            # Folder
            { name = "*/", use = [ "edit", "open", "reveal" ] },
            # Text
            { mime = "text/*", use = [ "edit", "reveal" ] },
            # Image
            { mime = "image/*", use = [ "open", "reveal" ] },
            # Media
            { mime = "{audio,video}/*", use = [ "play", "reveal" ] },
            # Archive
            { mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}", use = [ "extract", "reveal" ] },
            # JSON
            { mime = "application/{json,ndjson}", use = [ "edit", "reveal" ] },
            { mime = "*/javascript", use = [ "edit", "reveal" ] },
            # Empty file
            { mime = "inode/empty", use = [ "edit", "reveal" ] },
            # Fallback
            { name = "*", use = [ "open", "reveal" ] },
        ]

        [tasks]
        micro_workers    = 10
        macro_workers    = 10
        bizarre_retry    = 3
        image_alloc      = 536870912  # 512MB
        image_bound      = [ 0, 0 ]
        suppress_preload = false

        [plugin]

        fetchers = [
            # Mimetype
            { id = "mime", name = "*", run = "mime", if = "!mime", prio = "high" },
        ]
        spotters = [
            { name = "*/", run = "folder" },
            # Code
            { mime = "text/*", run = "code" },
            { mime = "*/{xml,javascript,wine-extension-ini}", run = "code" },
            # Image
            { mime = "image/{avif,hei?,jxl,svg+xml}", run = "magick" },
            { mime = "image/*", run = "image" },
            # Video
            { mime = "video/*", run = "video" },
            # Fallback
            { name = "*", run = "file" },
        ]
        preloaders = [
            # Image
            { mime = "image/{avif,hei?,jxl,svg+xml}", run = "magick" },
            { mime = "image/*", run = "image" },
            # Video
            { mime = "video/*", run = "video" },
            # PDF
            { mime = "application/pdf", run = "pdf" },
            # Font
            { mime = "font/*", run = "font" },
            { mime = "application/ms-opentype", run = "font" },
        ]
        previewers = [
            { name = "*/", run = "folder", sync = true },
            # Code
            { mime = "text/*", run = "code" },
            { mime = "*/{xml,javascript,wine-extension-ini}", run = "code" },
            # JSON
            { mime = "application/{json,ndjson}", run = "json" },
            # Image
            { mime = "image/{avif,hei?,jxl,svg+xml}", run = "magick" },
            { mime = "image/*", run = "image" },
            # Video
            { mime = "video/*", run = "video" },
            # PDF
            { mime = "application/pdf", run = "pdf" },
            # Archive
            { mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}", run = "archive" },
            { mime = "application/{debian*-package,redhat-package-manager,rpm,android.package-archive}", run = "archive" },
            { name = "*.{AppImage,appimage}", run = "archive" },
            # Virtual Disk / Disk Image
            { mime = "application/{iso9660-image,qemu-disk,ms-wim,apple-diskimage}", run = "archive" },
            { mime = "application/virtualbox-{vhd,vhdx}", run = "archive" },
            { name = "*.{img,fat,ext,ext2,ext3,ext4,squashfs,ntfs,hfs,hfsx}", run = "archive" },
            # Font
            { mime = "font/*", run = "font" },
            { mime = "application/ms-opentype", run = "font" },
            # Empty file
            { mime = "inode/empty", run = "empty" },
            # Fallback
            { name = "*", run = "file" },
        ]

        [input]
        cursor_blink = false

        # cd
        cd_title  = "Change directory:"
        cd_origin = "top-center"
        cd_offset = [ 0, 2, 50, 3 ]

        # create
        create_title  = [ "Create:", "Create (dir):" ]
        create_origin = "top-center"
        create_offset = [ 0, 2, 50, 3 ]

        # rename
        rename_title  = "Rename:"
        rename_origin = "hovered"
        rename_offset = [ 0, 1, 50, 3 ]

        # filter
        filter_title  = "Filter:"
        filter_origin = "top-center"
        filter_offset = [ 0, 2, 50, 3 ]

        # find
        find_title  = [ "Find next:", "Find previous:" ]
        find_origin = "top-center"
        find_offset = [ 0, 2, 50, 3 ]

        # search
        search_title  = "Search via {n}:"
        search_origin = "top-center"
        search_offset = [ 0, 2, 50, 3 ]

        # shell
        shell_title  = [ "Shell:", "Shell (block):" ]
        shell_origin = "top-center"
        shell_offset = [ 0, 2, 50, 3 ]

        [confirm]
        # trash
        trash_title 	= "Trash {n} selected file{s}?"
        trash_origin	= "center"
        trash_offset	= [ 0, 0, 70, 20 ]

        # delete
        delete_title 	= "Permanently delete {n} selected file{s}?"
        delete_origin	= "center"
        delete_offset	= [ 0, 0, 70, 20 ]

        # overwrite
        overwrite_title   = "Overwrite file?"
        overwrite_content = "Will overwrite the following file:"
        overwrite_origin  = "center"
        overwrite_offset  = [ 0, 0, 50, 15 ]

        # quit
        quit_title   = "Quit?"
        quit_content = "The following task is still running, are you sure you want to quit?"
        quit_origin  = "center"
        quit_offset  = [ 0, 0, 50, 15 ]

        [pick]
        open_title  = "Open with:"
        open_origin = "hovered"
        open_offset = [ 0, 1, 50, 7 ]

        [which]
        sort_by      	 = "none"
        sort_sensitive = false
        sort_reverse 	 = false
        sort_translit  = false
    '';
  };

  home.sessionVariables = {
    YAZI_CONFIG = "${config.home.homeDirectory}/.config/yazi/config.toml"; # Exemple pour un fichier de config perso
  };
}