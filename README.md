# amap-dev-website

This repository contains the source code of the website of `amap-dev` group of the AMAP laboratory. It is public and available at <https://sites.amaplab.fr/polis/dev/>.

This website is created using [`Quarto`](https://quarto.org).

As it is work in progress, the website is not yet published.

To get a render of the website, you need to clone the repository and have `Quarto` installed.

Instructions to install `Quarto` and get your favorite IDE ready can be found [here](https://quarto.org/docs/get-started/).

To render the website, you can simply:

```bash
# preview the website in the current directory
quarto preview
# render the website in the current directory (but no preview)
quarto render
```

or use the dedicated shortcuts of the IDE.

and to publish the website once it has been rendered (only from CIRAD and with your machine registered via ssh keys):

```bash
rsync -avzr --delete -e ssh --chown=www-data:www-data ./_site/
amap@palais.cirad.fr:/var/www/sites/polis/dev
```
