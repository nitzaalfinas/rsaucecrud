# Rsaucecrud
This gem will help you to create an advanced CRUD.

## Usage
Once you install this application, you can try to create a form;
```bash
$ rails console
> rsaucecrud('Namespace', 'Controller', 'Model', [:field_a, :field_b, :field_c])
```
Example;
```bash
$ rails console
> rsaucecrud('Patient', 'Symptoms', 'Symptom', Symptom.colum_names)
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'rsaucecrud', git: 'https://github.com/nitzaalfinas/rsaucecrud.git'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install rsaucecrud
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
