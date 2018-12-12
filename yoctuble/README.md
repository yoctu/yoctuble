# Yoctu Website Private

## Apache2 configuration for using

Mods to enable:
    - cgi

Vhosts config file:
```
    define documentroot YOUR/DOCUMENTROOT

    DocumentRoot ${documentroot}

    <Directory ${documentroot}>

        Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch 

        AddHandler cgi-script .sh

        RewriteEngine On
            RewriteCond %{REQUEST_FILENAME} -s [OR]
            RewriteCond %{REQUEST_FILENAME} -l [OR]
            RewriteCond %{REQUEST_FILENAME} -d
            RewriteRule ^.*$ - [NC,L]
            RewriteRule ^.*$ /main.sh [NC,L]

        DirectoryIndex main.sh

    </Directory>

    undefine documentroot
```

## HowTo

 

## Requirements
- yosh
- beanstalk-bash-client
