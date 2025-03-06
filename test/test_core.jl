using Test
using JuliaStructure

@testset "Core" begin
    @testset "Types" begin
        @testset "User" begin
            # Test basic constructor
            user = Types.User("test_user", "password123", "user@example.com")
            @test user.username == "test_user"
            @test user.password == "password123"
            @test user.email == "user@example.com"
            
            # Test with different email formats
            user2 = Types.User("john.doe", "pass", "john.doe+work@company.co.uk")
            @test user2.username == "john.doe"
            @test user2.email == "john.doe+work@company.co.uk"
        end

        @testset "Product" begin
            # Test basic constructor
            product = Types.Product(1, "Test Product", 29.99)
            @test product.id == 1
            @test product.name == "Test Product"
            @test product.price == 29.99
            
            # Test with different price formats
            product2 = Types.Product(2, "Expensive Item", 1_000.00)
            @test product2.id == 2
            @test product2.price == 1000.00
            
            # Test with integer price
            product3 = Types.Product(3, "Budget Item", 10)
            @test product3.price == 10.0  # Should be converted to Float64
        end

        @testset "Order" begin
            # Test basic order creation
            user = Types.User("customer", "pass", "customer@shop.com")
            products = [
                Types.Product(1, "Product 1", 10.0),
                Types.Product(2, "Product 2", 20.0)
            ]
            order = Types.Order(1, user, products)
            
            # Test order properties
            @test order.id == 1
            @test order.user === user
            @test order.products === products
            @test order.total == 30.0  # Sum of product prices
            
            # Test empty order
            empty_order = Types.Order(2, user, Types.Product[])
            @test empty_order.total == 0.0
            
            # Test order with single product
            single_product = [Types.Product(3, "Single Item", 15.99)]
            single_order = Types.Order(3, user, single_product)
            @test single_order.total == 15.99
        end
    end

    @testset "Config" begin
        # Test configuration values
        @test isdefined(JuliaStructure.Config, :MAX_PRODUCTS_PER_ORDER)
        @test isdefined(JuliaStructure.Config, :DEFAULT_DISCOUNT_PERCENT)
        @test isdefined(JuliaStructure.Config, :API_VERSION)
        
        # Test configuration types
        @test JuliaStructure.Config.MAX_PRODUCTS_PER_ORDER isa Integer
        @test JuliaStructure.Config.DEFAULT_DISCOUNT_PERCENT isa Real
        @test JuliaStructure.Config.API_VERSION isa String
        
        # Test configuration constraints
        @test JuliaStructure.Config.MAX_PRODUCTS_PER_ORDER > 0
        @test 0 <= JuliaStructure.Config.DEFAULT_DISCOUNT_PERCENT <= 100
        @test !isempty(JuliaStructure.Config.API_VERSION)
    end
end 
