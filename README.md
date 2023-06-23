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
```bash
  # Example CRON task "1 * * * * /path/to/monitor.sh > /dev/null"
  # (script must by executable: "sudo chmod +x monitor.sh")
  
  $ sh ./monitor.sh [-l]
```

**Options**

`-l` send load average data

Copyright (c) 2022-2023 Status Stack