# Evaka Keycloak Theme

This project has Evaka Theme for [KeyCloak](https://www.keycloak.org/). Theme is modified version of [Helsinki KeyCloak theme](https://github.com/City-of-Helsinki/helsinki-keycloak-theme).

## Tagging image

Git version tags are used to tag docker images.

First ensure that commit pipeline is succesfully finished. Then tag the commit:

```bash
git tag v0.1.0 # replace v0.1.0 with correct version
git push --tags
```

Tag must start with `v`. Suffixes with `-` are supported, example `v0.1.0-example-1`.
