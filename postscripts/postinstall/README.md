# postinstall scripts

The `compute.postinstall` script will look into the `postinstall.d` directory and execute any postscripts that have 755 permission. 

To add this to your `osimage` definition: 

```
# Assumes that this repo has been cloned to `/install` on your management node
chdef -t osimage <osimage> -p postinstall=/install/xcat-extensions/postscripts/postinstall/compute.postinstall
```

