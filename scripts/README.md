# Repository maintenance tools

The `scripts/` folder contains small checks used to keep the API directory tidy and to catch broken links before changes are proposed.

## Folder map

```text
scripts/
├── github_pull_request.sh     # local checks used while preparing changes
├── requirements.txt           # Python packages used by the checks
├── tests/                     # automated tests
└── validate/                  # README formatting and link checks
```

## Set up

Install [Python 3](https://www.python.org/) first. From the repository root, install the packages listed for the maintenance tools:

```bash
python -m pip install -r scripts/requirements.txt
```

## Check the directory

Run these commands from the root of this repository.

Check the README table formatting:

```bash
python scripts/validate/format.py README.md
```

Check links in the README:

```bash
python scripts/validate/links.py README.md
```

A full link pass can take a while because the directory contains many external sites. To check for duplicates without requesting every link, use:

```bash
python scripts/validate/links.py README.md -odlc
```

The `-odlc` flag is short for `--only_duplicate_links_checker`.

## Run the tests

From the repository root:

```bash
python -m unittest discover scripts/tests/ --verbose
```

To focus on one test file, add a pattern:

```bash
python -m unittest discover scripts/tests/ --verbose --pattern "test_validate_format.py"
python -m unittest discover scripts/tests/ --verbose --pattern "test_validate_links.py"
```
