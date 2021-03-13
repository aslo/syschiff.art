# syschiff.art

A website that showcases the work of Sy Schiff, built with [Jekyll](https://github.com/jekyll/jekyll).

## Install

```bash
gem install bundler && bundle install
```

## Develop

```bash
# Start the jekyll development server:
bundle exec jekyll serve
```

## Deploy

Prerequisite: install the [AWS CLI](https://docs.aws.amazon.com/cli/index.html) and 
[`s3deploy`](https://github.com/bep/s3deploy).

```bash
./scripts/deploy_aws.sh
```
