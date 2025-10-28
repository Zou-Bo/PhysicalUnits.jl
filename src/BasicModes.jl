module ħkB4πϵ0_meVnm

    export ReducedPlanckConstant, BoltzmannConstant
    export SpeedOfLight, VacuumElectricPermittivity
    export ElectronMass, ElementaryCharge, BohrMagneticMoment
    export meV, nm, eV, Meter, cm
    export Voltage, ns, Second
    export Tesla, Kelvin, Joule, Watt
    export InverseFineStructureConstant, Gram, kg

    const doc::String = "ħ=1, k_B=1, 4πϵ₀=1; meV=1, nm=1. Based on CODATA 2018 values."

    #####################################
    # Base units and definitions
    const ReducedPlanckConstant = 1.;
    const BoltzmannConstant = 1.;
    const VacuumElectricPermittivity = 1.0 / 4π;
    const meV = 1.;
    const nm = 1.;

    # Derived units
    const eV = 1000meV;
    const Meter = 1e9nm;
    const cm = 1e7nm;

    # Conversion factors from CODATA 2018
    # 1 J = 1 / (1.602176634e-19) eV
    const Joule = 6.24150907446076e21 * meV;

    # ħ = 6.582119569e-16 eV.s = 6.582119569e-13 meV.s
    # 1s = 1 / (6.582119569e-13) meV⁻¹
    # 1ns = 1e-9s = 1e-9 / (6.582119569e-13) meV⁻¹ = 1519.267... meV⁻¹
    const ns = 1.51926701e3 * meV^(-1);
    const Second = 1e9ns;
    const Watt = Joule/Second;

    # ħc = 197.3269804 eV.nm = 197326.9804 meV.nm
    # With ħ=1, c = 197326.9804 in units of nm.meV/ħ
    const SpeedOfLight = 197326.9804;

    # α⁻¹ = 137.035999084
    const InverseFineStructureConstant = 137.035999084;
    # e² = c / α
    const ElementaryCharge = sqrt(SpeedOfLight / InverseFineStructureConstant) * sqrt(meV * nm);

    # m_e = 0.51099895000 MeV/c² = 5.1099895000e8 meV/c²
    # In this system, mass unit is 1/(meV.nm²)
    # m_e = 5.1099895000e8 / c²
    const ElectronMass = 5.1099895000e8 / SpeedOfLight^2 * meV^(-1)*nm^(-2);

    const BohrMagneticMoment = ElementaryCharge/ElectronMass/2;
    const Voltage = eV / ElementaryCharge;

    # k_B = 8.617333262e-5 eV/K
    # 1K = 8.617333262e-5 eV / k_B = 0.08617333262 meV / k_B
    const Kelvin = 8.617333262e-2 * meV;

    # 1 T = 1 V.s/m²
    const Tesla = (1e-9Voltage/nm) / (1nm/ns);

    # Mass units
    # 1 kg = 1.09776912e30 * m_e
    const kg = 1.44043e28;
    const Gram = kg / 1000;
    #####################################
end

const Unit_ħkB4πϵ0_meVnm = ħkB4πϵ0_meVnm

module ħkB4πϵ0c_eV

    export ReducedPlanckConstant, BoltzmannConstant
    export SpeedOfLight, VacuumElectricPermittivity
    export ElectronMass, ElementaryCharge, BohrMagneticMoment
    export meV, nm, eV, Meter, cm
    export Voltage, ns, Second
    export Tesla, Kelvin, Joule, Watt
    export InverseFineStructureConstant, Gram, kg

    const doc::String = "ħ=1, k_B=1, 4πϵ₀=1, c=1; eV=1. Based on CODATA 2018 values."

    #####################################
    # Base units and definitions
    const ReducedPlanckConstant = 1.;
    const BoltzmannConstant = 1.;
    const SpeedOfLight = 1.;
    const VacuumElectricPermittivity = 1.0 / 4π;
    const eV = 1.;
    const meV = 1e-3*eV;

    # α⁻¹ = 137.035999084
    const InverseFineStructureConstant = 137.035999084;
    # e² = α
    const ElementaryCharge = sqrt(1 / InverseFineStructureConstant);

    # Length units
    # ħc = 197.3269804 eV.nm => nm = 197.3269804 eV⁻¹ (with ħ=c=1)
    const nm = 1 / 197.3269804;
    const Meter = 1e9nm;
    const cm = 1e7nm;

    # Time units
    # 1s = 1.519267...e15 eV⁻¹
    const Second = 1.51926701e15 / eV;
    const ns = 1e-9 * Second;

    # Mass units
    # m_e = 0.51099895e6 eV
    const ElectronMass = 5.1099895e5 * eV;
    # 1kg = 5.6095886e35 eV
    const kg = 5.60958e35 * eV;
    const Gram = kg / 1000;

    # Other derived units
    const BohrMagneticMoment = ElementaryCharge/(2*ElectronMass);
    const Voltage = eV / ElementaryCharge;
    const Joule = 6.24150907446076e18 * eV;
    const Watt = Joule/Second;
    const Kelvin = 8.617333262e-5 * eV;
    const Tesla = 1.0; # This is complex, placeholder
    #####################################
end