## Instructions

Build your custom version of OpenCode:
```bash
nix build
```

Load you environment variables:
```bash
source env.sh
```

Run executable:
```bash
# Directly from github:
nix run github:mirko-plowtech/opencode-mk

# Or make it temporally available in your shell:
export PATH="$PATH:/home/ogt/repositories/opencode-mk/result/bin"

# And then run it:
my-opencode
```