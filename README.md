# I18nAccessor

[![Circle CI](https://circleci.com/gh/criticaljuncture/i18n_accessor.svg?style=shield)](https://circleci.com/gh/criticaljuncture/i18n_accessor)

I18nAccessor uses a little metaprogramming to provide some syntactic sugar that
will help clean up your views when using I18n to display static properties on an
object.

I18nAccessor is especially useful in combination with ActiveHash where you now
only need an `:identifier` attribute and can remove all other string based
values from the data array.

See Usage and Examples sections below.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'i18n_accessor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install i18n_accessor

## Usage
Add `i18n_accessor` to your model as follows: `i18n_accessor :accessor`

This will look up the corresponding translation as follows:
```yml
# config locales/en.yml, etc
model_name:
  accessor: 'your string'
```  

I18nAccessor also accepts a second `:scope` param as follows:
`i18n_accessor :accessor, scope: 'short'`

This will look up the corresponding translation as follows:
```yml
# config/locales/en.yml, etc
model_name:
  accessor:
    short: 'your string'
```

Often however when using `:scope` you'll have want to have more than one
accessor for the same key. In these cases you should also pass the `:key`
parameter:

```ruby
# app/models/product.rb
i18n_accessor :short_category, key: "category", scope: "short"
i18n_accessor :long_category, key: "category", scope: "long"

# config/locales/en.yml
model_name:
  key:
    short: 'your string'
    long: 'your longer, more verbose string'
```

Scope can be any arbitrarily long string that you would use with the
I18n#translate method.

Scope is useful when you want to defined multiple accessors for the same key.

## Examples

### Simple
Simple usage is great for wrapping I18n strings in a method.

For example:

```ruby
# app/models/product.rb
class Product
  i18n_accessor :name
end

# config/locales/en.yml
product:
  name: 'Product'

# app/views/products/show.html.erb
# you get:
<%= @product.name %>

# rather than:
<%= I18n.t('product.name') %>
```

### ActiveHash
When used with ActiveHash it allows you to remove all strings from your
data array and making it less verbose while also giving you get the added
benefit of the I18n translation layer.

When I18nAccessor detects your model inherits from ActiveHash::Base it assumes
that you have an `:identifer` key and uses the value of this to do the i18n
lookup.

A typical entry in an ActiveHash data array might look like:
```ruby
# app/model/grade.rb
...
{id: 7, identifier: :first, long_name: 'First grade', short_name: '1st'},
...
```

With I18nAccessor:

```ruby
# app/models/grade.rb
class Grade < ActiveHash::Base
  include ActiveHashI18n
  i18n_accessor :short_name, scope: 'short'
  i18n_accessor :long_name, scope: 'long'

  self.data = [
    {id: 0,   identifier: :kindergarten},
    {id: 1,   identifier: :first},
    {id: 2,   identifier: :second}
    #...
  ]
end

# config/locales/en.yml
grade:
  kindergarten:
    long: Kindergarten
    short: Kindergarten
  first:
    long: First grade
    short: 1st Grade
  second:
    long: Second grade
    short: 2nd Grade

# app/views/grades/show.html.erb
<%= @grade.short_name %>
<%= @grade.long_name %>
```

Without I18nAccessor you'd end up with each element of your active_hash data
array needing a short_name and long_name key and value
(eg. `short_name: I18n.t('grade.kindergarten.short')`).

Note: when using `:scope` with ActiveHash you don't specify a `:key`
when creating multiple accessors. This is because the key is inferred from the
`:identifier` property on the data item.

When using I18nAccessor on an ActiveHash based class in order to create an
accessor that isn't based on the currently instantiated object you'll need to
pass the `:key` argument. This allows you to also make the use of simple case
outlined above.

```ruby
# app/models/grade.rb
i18n_accessor :name, key: 'name'

# config/locales/en.yml
grade:
  name: Grade
  kindergarten:
    long: Kindergarten
    short: Kindergarten
  ...
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/i18n_accessor/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
