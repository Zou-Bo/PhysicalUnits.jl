module PhysicalUnits

include("modes.jl")

using .Unit_ħkB4πϵ0_meVnm

export ReducedPlanckConstant, BoltzmannConstant
export ElectronMass, ElementaryCharge, BohrMagneticMoment
export SpeedOfLight, VacuumElectricPermittivity
export meV, nm, eV, Meter, cm
export Voltage, ns, Second
export Tesla, Kelvin, Joule, Watt

end
