using JuliaStructure
using Test

@testset "JuliaStructure.jl" begin
    # Test MathUtils module
    @testset "MathUtils" begin
        # Test mean function
        @test MathUtils.calculate_mean([1, 2, 3, 4, 5]) == 3.0
        @test MathUtils.calculate_mean([-10, -5, 0, 5, 10]) == 0.0
        @test MathUtils.calculate_mean([1.5, 2.5, 3.5]) == 2.5
        
        # Test median function
        @test MathUtils.calculate_median([1, 3, 2, 5, 4]) == 3.0
        @test MathUtils.calculate_median([1, 3, 2, 4]) == 2.5
        
        # Test variance function
        @test isapprox(MathUtils.calculate_variance([2, 4, 4, 4, 5, 5, 7, 9]), 4.5714285714285715)
        
        # Test standard deviation function
        @test isapprox(MathUtils.calculate_std([2, 4, 4, 4, 5, 5, 7, 9]), sqrt(4.5714285714285715))
    end
    
    # Test Helpers module
    @testset "Helpers" begin
        # Test calculate_discount function
        @test Helpers.calculate_discount(100.0, 10.0) == 90.0
        @test Helpers.calculate_discount(50.0, 5.0) == 47.5
        
        # Test validate_email function
        @test Helpers.validate_email("user@example.com") == true
        @test Helpers.validate_email("invalid-email") == false
    end
    
    # Test Types module
    @testset "Types" begin
        # Test User struct
        user = Types.User("test_user", "password", "user@example.com")
        @test user.username == "test_user"
        @test user.password == "password"
        @test user.email == "user@example.com"
        
        # Test Product struct
        product = Types.Product(1, "Test Product", 29.99)
        @test product.id == 1
        @test product.name == "Test Product"
        @test product.price == 29.99
        
        # Test Order constructor with calculated total
        user = Types.User("test_user", "password", "user@example.com")
        products = [
            Types.Product(1, "Product 1", 10.0),
            Types.Product(2, "Product 2", 20.0)
        ]
        order = Types.Order(1, user, products)
        @test order.total == 30.0
    end
end