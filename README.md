# Status Stack SDK for Linux

Install
-------
```bash
  # WGET
  $ wget https://github.com/Status-Stack/sdk-linux/archive/refs/tags/v1.0.0.zip
  $ unzip v1.0.0.zip
```

Usage
-----
```bash
  # Example CRON task "1 * * * * /path/to/monitor.sh > /dev/null"
  # (script must by executable: "sudo chmod +x monitor.sh")
  
  $ sh ./monitor.sh [-l] [-s <filesystem>]
```

**Options**

`-l` send load average data

`-s <filesystem>` send space usage data

Copyright (c) 2022-2023 Status Stack