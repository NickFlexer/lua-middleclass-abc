---
-- example.lua


package.path = package.path .. ";lib/?/init.lua;lib/?.lua"


local class = require "middleclass"
local ABC = require "abc"


local AbstractClass = class("AbstractClass", ABC)

function AbstractClass:initialize()
    -- call ABC constructor
    ABC.initialize(self)
    -- set all marked abstract methods to class
    self:set_abstract_methods(AbstractClass)
end

-- add return self.abstractmethod to mark abstract method
function AbstractClass:first_method()
    return self.abstractmethod
end

function AbstractClass:second_method()
    return self.abstractmethod
end


-- Implement every abstract method
local CorrectConcreteClass = class("CorrectConcreteClass", AbstractClass)

function CorrectConcreteClass:initialize()
    -- call superclass constructor
    AbstractClass.initialize(self)
    -- check that all abstract methods is overridden
    self:check_abstract_methods(CorrectConcreteClass)
end

function CorrectConcreteClass:first_method()
    print("I'm correct first method!")
end

function CorrectConcreteClass:second_method()
    print("I'm correct second method!")
end


-- Implement only one abstract method
local IncorrectConcreteClass = class("IncorrectConcreteClass", AbstractClass)

function IncorrectConcreteClass:initialize()
    -- call superclass constructor
    AbstractClass.initialize(self)
    -- check that all abstract methods is overridden
    self:check_abstract_methods(IncorrectConcreteClass)
end

function IncorrectConcreteClass:first_method()
    print("I'm correct first method!")
end


function main()
    -- create instance of correct class
    local correct_concrete_class = CorrectConcreteClass()
    correct_concrete_class:first_method()
    correct_concrete_class:second_method()

    -- create instance of incorrect class
    local incorrect_concrete_class = IncorrectConcreteClass()
    incorrect_concrete_class:first_method()
    incorrect_concrete_class:second_method()
end


main()
