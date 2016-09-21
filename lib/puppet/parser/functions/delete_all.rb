module Puppet::Parser::Functions
  newfunction(:delete_all, :type => :rvalue, :doc => <<-EOS
Deletes all instances of an array of elements from an array, substring from a
string, or key from a hash.

*Examples:*

    delete_all(['a','b','c','b'], ['b', 'c'])
    Would return: ['a']

    delete_all({'a'=>1,'b'=>2,'c'=>3}, ['b', 'c'])
    Would return: {'a'=>1}

    delete_all('abracadabra', ['bra','ca'])
    Would return: 'ada'
    EOS
  ) do |arguments|

    if (arguments.size != 2) then
      raise(Puppet::ParseError, "delete_all(): Wrong number of arguments "+
        "given #{arguments.size} for 2.")
    end

    collection = arguments[0].dup
    items = arguments[1]

    unless items.is_a?(Array)
      raise(TypeError, "delete_all(): Second argument must be an Array. Given an argument of class #{collection.class}.")
    end

    case collection
    when Array, Hash
      items.each do |item|
        collection.delete item
      end
    when String
      items.each do |item|
        collection.gsub! item, ''
      end
    else
      raise(TypeError, "delete_all(): First argument must be an Array, " +
            "String, or Hash. Given an argument of class #{collection.class}.")
    end
    collection
  end
end
