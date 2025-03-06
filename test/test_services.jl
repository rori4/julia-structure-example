using Test
using JuliaStructure
using Statistics
using Dates

@testset "Services" begin
    @testset "AnalyticsService" begin
        # Test data setup
        test_products = [
            Types.Product(1, "Product 1", 10.0),
            Types.Product(2, "Product 2", 20.0),
            Types.Product(3, "Product 3", 30.0),
            Types.Product(4, "Product 4", 40.0)
        ]

        # Test analyze_data function
        @testset "analyze_data" begin
            # Test with valid products
            result = AnalyticsService.analyze_data(test_products)
            
            @test result[:count] == 4
            @test result[:min_price] == 10.0
            @test result[:max_price] == 40.0
            @test result[:avg_price] == 25.0
            @test result[:median_price] == 25.0
            @test result[:total_value] == 100.0
            @test result[:discounted_total] == 90.0  # 10% discount
            @test result[:savings] == 10.0

            # Test with empty products
            empty_result = AnalyticsService.analyze_data(Types.Product[])
            @test empty_result[:status] == "error"
            @test empty_result[:message] == "No products to analyze"
        end

        # Test generate_report function
        @testset "generate_report" begin
            analysis_data = Dict{Symbol, Any}(
                :count => 4,
                :min_price => 10.0,
                :max_price => 40.0,
                :avg_price => 25.0,
                :median_price => 25.0,
                :total_value => 100.0,
                :discounted_total => 90.0,
                :savings => 10.0
            )

            report = AnalyticsService.generate_report(analysis_data)
            
            # Test report content
            @test contains(report, "Number of products: 4")
            @test contains(report, "Price range: \$10.0 - \$40.0")
            @test contains(report, "Average price: \$25.0")
            @test contains(report, "Median price: \$25.0")
            @test contains(report, "Total inventory value: \$100.0")
            @test contains(report, "Value after 10% discount: \$90.0")
            @test contains(report, "Potential savings: \$10.0")
            @test contains(report, "Report generated on:")
        end

        # Test perform_advanced_analysis function
        @testset "perform_advanced_analysis" begin
            # First ensure we have some test data
            test_product = Types.Product(5, "Test Product", 25.99)
            DataService.save_data(:products, test_product)
            
            result = AnalyticsService.perform_advanced_analysis()
            @test result isa Dict{Symbol, Any}
            @test haskey(result, :count)
            @test result[:count] ≥ 1  # Should have at least our test product
            @test haskey(result, :total_value)
            @test result[:total_value] > 0
        end
    end

    @testset "DataService" begin
        # Test fetch_data function
        @testset "fetch_data" begin
            products = DataService.fetch_data("http://example.com/api/products")
            @test length(products) == 3
            @test products[1] isa Types.Product
            @test products[1].id == 1
            @test products[1].name == "Product 1"
            @test products[1].price == 19.99
        end

        # Test save_data function
        @testset "save_data" begin
            # Test saving a new product
            new_product = Types.Product(4, "Test Product", 49.99)
            @test DataService.save_data(:products, new_product) == true

            # Test saving to a new entity type
            @test DataService.save_data(:new_entity, "test") == true
        end

        # Test query_data function
        @testset "query_data" begin
            # Query existing products
            products = DataService.query_data(:products, p -> p.price > 20.0)
            @test length(products) ≥ 2  # Should find Product 2 and 3 from fetch_data
            @test all(p -> p.price > 20.0, products)

            # Query non-existent entity type
            @test isempty(DataService.query_data(:non_existent, x -> true))

            # Query with specific filter
            expensive_products = DataService.query_data(:products, p -> p.price > 30.0)
            @test all(p -> p.price > 30.0, expensive_products)
        end
    end
end 
