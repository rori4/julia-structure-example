using Test
using JuliaStructure
using Dates

@testset "Utils" begin
    @testset "Helpers" begin
        @testset "format_datetime" begin
            test_date = DateTime(2024, 3, 6, 15, 30, 45)
            @test Helpers.format_datetime(test_date) == "2024-03-06 15:30:45"
            
            # Test with different date components
            test_date2 = DateTime(2024, 12, 31, 23, 59, 59)
            @test Helpers.format_datetime(test_date2) == "2024-12-31 23:59:59"
            
            # Test with single digit components
            test_date3 = DateTime(2024, 1, 5, 9, 5, 1)
            @test Helpers.format_datetime(test_date3) == "2024-01-05 09:05:01"
        end

        @testset "calculate_discount" begin
            # Test normal cases
            @test Helpers.calculate_discount(100.0, 10.0) == 90.0
            @test Helpers.calculate_discount(50.0, 5.0) == 47.5
            @test Helpers.calculate_discount(75.0, 25.0) == 56.25
            @test Helpers.calculate_discount(100.0, 0.0) == 100.0
            @test Helpers.calculate_discount(100.0, 100.0) == 0.0
            
            # Test edge cases and errors
            @test_throws ArgumentError Helpers.calculate_discount(100.0, -10.0)
            @test_throws ArgumentError Helpers.calculate_discount(100.0, 110.0)
            @test_throws ArgumentError Helpers.calculate_discount(-100.0, 10.0)
        end

        @testset "validate_email" begin
            # Test valid email addresses
            @test Helpers.validate_email("user@example.com") == true
            @test Helpers.validate_email("user.name+tag@example.co.uk") == true
            @test Helpers.validate_email("user123@sub.domain.com") == true
            @test Helpers.validate_email("first.last@company.org") == true
            
            # Test invalid email addresses
            @test Helpers.validate_email("invalid-email") == false
            @test Helpers.validate_email("@invalid.com") == false
            @test Helpers.validate_email("user@") == false
            @test Helpers.validate_email("user@.com") == false
            @test Helpers.validate_email("user@domain") == false
            @test Helpers.validate_email("") == false
        end

        @testset "generate_id" begin
            # Test basic functionality
            id1 = Helpers.generate_id()
            id2 = Helpers.generate_id()
            
            @test id1 isa Int
            @test id2 isa Int
            @test 0 <= id1 <= 9999
            @test 0 <= id2 <= 9999
            
            # Test uniqueness with multiple IDs
            ids = [Helpers.generate_id() for _ in 1:100]
            @test length(unique(ids)) > 90  # Allow for some collisions due to random nature
            
            # Test range consistency
            @test all(id -> 0 <= id <= 9999, ids)
        end
    end
end 
