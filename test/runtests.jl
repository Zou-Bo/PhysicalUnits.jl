using PhysicalUnits
using Test

@testset "PhysicalUnits.jl" begin
    # Initial values are 0.0
    @test nm == 0.0
    @test ReducedPlanckConstant == 0.0
end

@testset "PhysicalUnit function" begin
    PhysicalUnit(:ħkB4πϵ0_meVnm)
    @test ReducedPlanckConstant == 1.0
    @test BoltzmannConstant == 1.0
    @test VacuumElectricPermittivity ≈ 1.0 / 4π
    @test meV == 1.0
    @test nm == 1.0
    @test eV == 1000.0
    @test SpeedOfLight ≈ 197326.9804
    @test ElementaryCharge ≈ 37.94686479
    @test ElectronMass ≈ 0.013123421188
    @test Kelvin ≈ 0.0861733326
    @test InverseFineStructureConstant ≈ 137.035999084
    @test kg ≈ 1.44043e28
    @test Gram ≈ 1.44043e25
end

@testset "ħkB4πϵ0c_eV mode" begin
    PhysicalUnit(:ħkB4πϵ0c_eV)
    @test ReducedPlanckConstant == 1.0
    @test BoltzmannConstant == 1.0
    @test SpeedOfLight == 1.0
    @test VacuumElectricPermittivity ≈ 1.0 / 4π
    @test eV == 1.0
    @test meV == 0.001
    @test InverseFineStructureConstant ≈ 137.035999084
    @test ElementaryCharge ≈ sqrt(1 / 137.035999084)
    @test nm ≈ 1 / 197.3269804
    @test Second ≈ 1.51926701e15
    @test ElectronMass ≈ 5.1099895e5
    @test kg ≈ 5.60958e35
end

@testset "current_mode function" begin
    PhysicalUnit(:ħkB4πϵ0_meVnm)
    @test current_mode() == :ħkB4πϵ0_meVnm
    PhysicalUnit(:ħkB4πϵ0c_eV)
    @test current_mode() == :ħkB4πϵ0c_eV
end

@testset "@with_units macro" begin
    # Set some initial global values
    PhysicalUnit(:ħkB4πϵ0_meVnm)
    Core.eval(PhysicalUnits, :(ReducedPlanckConstant = 123.0))
    @test ReducedPlanckConstant == 123.0

    @with_units :ħkB4πϵ0_meVnm begin
        @test ReducedPlanckConstant == 1.0
        @test BoltzmannConstant == 1.0
        @test VacuumElectricPermittivity ≈ 1.0 / 4π
        @test meV == 1.0
        @test nm == 1.0
        @test eV == 1000.0
        @test SpeedOfLight ≈ 197326.9804
    end

    @with_units :ħkB4πϵ0c_eV begin
        @test ReducedPlanckConstant == 1.0
        @test BoltzmannConstant == 1.0
        @test SpeedOfLight == 1.0
        @test eV == 1.0
        @test meV == 0.001
    end

    # Test that the global value is not changed by the macro
    @test ReducedPlanckConstant == 123.0
end