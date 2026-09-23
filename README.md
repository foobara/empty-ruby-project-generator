# Foobara::EmptyRubyProjectGenerator

Generates an empty Ruby project with RuboCop, RSpec, and GitHub Actions already wired up, so you can focus on writing your gem's code rather than setting up boilerplate code. 

The generated project is ideally meant to be used with Foobara however, it can also be used for non-Foobara projects by deleting Foobara-specific parts after generation. 

## Installation

The `foobara-empty-ruby-project-generator` is part of the `foob` family of code generators. Installing the `foob` gem will therefore automatically bring in this generator along with all other foobara generators eliminating the need to install the `foobara-empty-ruby-project-generator` gem separately. 

Install the gem directly in the terminal:

    `$ gem install foob`

Or add it to your Gemfile:

    `$ bundle add foob`

## Usage

Run the generator to create a new project:

    `$ foob g ruby-project -n NAME [options]`

The `-n` flag represents the name of the project to be generated and is required. It accepts either a plain project name or a name in the 
`org/project` format:

- **Individual account:** `-n my-gem` — creates a project with a single 
  module e.g. `MyGem`
- **Organization:** `-n my-org/my-gem` — creates a project with a nested 
  module e.g. `MyOrg::MyGem` and uses `my-org` as the GitHub organization

For a full list of available options run:

    `$ foob g ruby-project --help`

or

    `$ foob help ruby-project`

**Commonly used options:**

| Flag | Description |
|------|-------------|
| `-n, --name` | Project name or org/project (required) |
| `-d, --description` | Project description. Defaults to `"No description. Add one."` |
| `-a, --author-names` | Author name(s) |
| `--author-emails` | Author email(s) |
| `-l, --license` | One of: `MIT`, `Apache-2.0`, `MPL-2.0`, `Apache-2.0 OR MIT` |
| `-u, --use-git` | Initialize a git repository |
| `--push-to-github` | Create a private GitHub repo and push to it |
| `-o, --output-directory` | Where to generate the project. Defaults to the project name |

**Example:**

    `$ foob g ruby-project -n my-org/my-gem -d "Does something useful" -l MIT --use-git`

The above generator example when run will put the project in the `my-org/my-gem` folder. 

Upon running the generator, all projects will have the following structure:

- `lib/` - Contains all files that are loaded via `require` and based on the name you provided when generating the project, this folder will be structured as either `lib/my_org/my_gem.rb` for an organisation project name OR `lib/my_gem.rb` for a plain project name.

- `src/` - Contains your ruby gem code. This is a Foobara-specific convention whereby instead of putting all your code in the `lib/` folder, the actual implementation code lives in `src/` folder while the `lib/` folder is reserved for code that can be required. 

If you used the `foobara-empty-ruby-project-generator` gem to generate a non-Foobara Ruby project, you can delete the `src/` folder and place all your code in the `lib/` folder as well as delete any associated Foobara-specific parts. 

## Contributing

Contributions in the form of PRs and issues are always welcome.

To work on an existing issue or submit a PR:

1. Fork the repo and clone it to your local machine
2. Run `bundle install` to install dependencies
3. Run `rake` to ensure that everything works as expected before making any changes. 
4. Implement your changes and add tests where applicable
5. Re-run `rake` to make sure that all tests and rubocop pass.
6. Commit, push to GitHub and open a PR for review

## License

This project is licensed under your choice of the Apache-2.0 license or 
the MIT license. See [LICENSE.txt](LICENSE.txt) for more info.