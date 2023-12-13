# Pensieve 
## Overview
Pensieve is a web application designed to help users preserve, organize, and revisit personal and family memories. It offers a user-friendly interface to simply show and manage memories, associated individuals, and more. [Full Functional Specification](https://gist.github.com/thierrychau/0d558373c7605ed4459f21a80ea86112)

## Features
- **Dashboard with Map View**: Visual representation of logged memories on an interactive map.
- **Memory Management**: Detailed memory pages with titles, descriptions, locations, pictures, and associated people.
- **Autogenerated Titles**: Utilizing OpenAI to automatically generate titles from memory descriptions.
- **People Management**: Individual profiles for registered individuals, linked to associated memories.
- **Cross-functionality**: Linking people to specific memories for easy reference.

## Getting Started
### Installation and usage
In development, use `bundle` to install all necessary gems:
```bash
bundle install
```
Launch a live preview with:
```bash
rails s
```
or
```bash
bin/dev
```

To populate the app with sample data for testing:
```bash
rails dev:sample_data
```

For resetting the development database:
```bash
rails dev:reset
```

Before deployment, you may want to update `config.mailer_sender` in `devise.rb`, `config.action_mailer.default_url_options` in `production.rb`, `database.yml`, `application_mailer.rb`.

### Dependencies
Pensieve is based on Ruby on Rails. The required gems are listed in the Gemfile. Additionally, accounts and API keys are needed for services like Cloudinary, OpenAI, MapBox, and PostMark.

### Configuration
Set the necessary secret keys as environment variables.
Update the mailers as required.

### Demo
[Pensieve.cc](https://pensieve.cc)

<img src="https://res.cloudinary.com/dvtzwb5ue/image/upload/f_auto,q_auto/Screenshot_2023-12-12_at_3.19.58_PM_ntr5tf" alt="Screenshot demo dashboard" width="50%" height="auto">

<img src="https://res.cloudinary.com/dvtzwb5ue/image/upload/f_auto,q_auto/Screenshot_2023-12-12_at_3.22.19_PM_brskjo" alt="Screenshot demo adding a memory" width="50%" height="auto">

<img src="https://res.cloudinary.com/dvtzwb5ue/image/upload/f_auto,q_auto/Screenshot_2023-12-12_at_3.22.19_PM_brskjo" alt="Screenshot demo people index" width="50%" height="auto">

### Contributing:
#### Issue Reporting

1. Fork the repository
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request and assign it to @thierrychau

#### Providing Details

When reporting issues, please include specific steps to reproduce errors. Screenshots are appreciated. Tag [thierrychau](https://github.com/thierrychau) in the issue for prompt attention.
