---
-- abc_spec.lua


package.path = package.path .. ";lib/?/init.lua;lib/?.lua"


local class = require "middleclass"
local ABC = require "abc"


describe("ABC", function ()

    local A

    setup(function()
        A = class("A", ABC)

        function A:initialize()
            ABC.initialize(self)
            self:set_abstract_methods(A)
        end

        function A:a()
            return self.abstractmethod
        end
    end)

    teardown(function()
        A = nil
    end)

    it("Owerride abstract method", function ()
        local B = class("B", A)

        function B:initialize()
            A.initialize(self)
            self:check_abstract_methods(B)
        end

        function B:a()
            return tostring(self)
        end

        assert.has_no.errors(function () B() end)
    end)

    it("Abstract method not implemented", function ()
        local B = class("B", A)

        function B:initialize()
            A.initialize(self)
            self:check_abstract_methods(B)
        end

        assert.has_error(function () B() end, "Can't instantiate abstract class B with abstract methods [ a,]")
    end)

    it("No abstract methods defined", function ()
        local C = class("C", ABC)

        function C:initialize()
            ABC.initialize(self)
            self:set_abstract_methods(C)
        end

        assert.has_error(function () C() end, "No abstract methods found! All abstract methods must return self.abstractmethod")
    end)

    it ("Abstract method not return self.abstractmethod", function ()
        local D = class("D", ABC)

        function D:initialize()
            ABC.initialize(self)
            self:set_abstract_methods(D)
        end

        function D:mistake()
            return true
        end

        assert.has_error(function () D() end, "No abstract methods found! All abstract methods must return self.abstractmethod")
    end)
end)
