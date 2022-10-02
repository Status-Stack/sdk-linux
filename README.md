# Status Stack SDK for Linux

Install
-------
```bash
  # WGET
  $ wget https://github.com/Status-Stack/sdk-linux/archive/refs/tags/v0.0.1-BETA.zip
  $ unzip v0.0.1-BETA.zip
```

Usage
-----

Load average monitor
```bash
  # Example CRON task "1 * * * * /path/to/monitor-load.sh > /dev/null"
  # (script must by executable: "sudo chmod +x monitor-load.sh")
  
  $ sh monitor-load.sh <HOST> <SECRET_KEY>
```

Copyright (c) 2022 Status Stack