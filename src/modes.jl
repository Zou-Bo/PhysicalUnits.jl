module Unit_ħkB4πϵ0_meVnm

    export ReducedPlanckConstant, BoltzmannConstant
    export ElectronMass, ElementaryCharge, BohrMagneticMoment
    export SpeedOfLight, VacuumElectricPermittivity
    export meV, nm, eV, Meter, cm
    export Voltage, ns, Second
    export Tesla, Kelvin, Joule, Watt


    #####################################
    # ħ=1, k_B=1, 4πϵ₀=1
    const ReducedPlanckConstant = 1.;
    const BoltzmannConstant = 1.;
    const VacuumElectricPermittivity = 1.0 / 4π;
    # unit: energy, frequency(ω)->meV, length->nm
    const meV = 1.; const nm = 1.;
    const eV = 1000meV; const Meter = 1e9nm; const cm = 1e7nm;
    const Joule = 6.2415e21meV;
    # derived units and constants:
    # mass, charge and voltage -> V
    const ElectronMass = 1.3123e-2 * meV^(-1)*nm^(-2);
    const ElementaryCharge = 37.947 * sqrt(meV * nm);
    const BohrMagneticMoment = ElementaryCharge/ElectronMass/2
    const Voltage = eV / ElementaryCharge
    # electric field -> V/nm
    # time->ns, volocity, SI magnetic field->Tesla
    const ns = 1.5193e3 * meV^(-1);
    const Second = 1e9ns;
    const Watt = Joule/Second;
    const SpeedOfLight = 2.9979e8 * nm/ns;
    const Tesla = (1e-9V/nm) / (1nm/ns)
    # temperature -> Kelvin
    const Kelvin = 8.6173e-2 * meV;
    #####################################
end