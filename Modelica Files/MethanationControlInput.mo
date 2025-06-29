within ;
model MethanationControlInput
  import SI = Modelica.Units.SI;
  import Modelica.Blocks.Interfaces.RealInput;
  import Modelica.Blocks.Interfaces.RealOutput;

  // Parameters
  parameter Real stoichRatio = 4 "H2:CO2 molar ratio (default = 4 for stoichiometric)";
  parameter SI.Time T = 0 "Response time for control ramp [s]";

  // Constants
  constant Real M_H2 = 2.0 "H2 molar mass [g/mol]";

  // Inputs
  RealInput m_H2_in "H2 mass flow rate [kg/s]"
    annotation (Placement(transformation(extent={{-120,0},{-100,20}})));

  // Outputs
  RealOutput n_H2_out "H2 molar flow rate [mol/s]"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  RealOutput n_CO2_out "CO2 molar flow rate [mol/s]"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));

  // Internal variables (target values)
  Real n_H2_target;
  Real n_CO2_target;

  // State variables for first-order delay
  Real n_H2_delayed(start=0);
  Real n_CO2_delayed(start=0);

equation
  // Convert to molar flow
  n_H2_target = m_H2_in * 1000 / M_H2;
  n_CO2_target = n_H2_target / stoichRatio;

  if T > 0 then
    der(n_H2_delayed) = (n_H2_target - n_H2_delayed) / T;
    der(n_CO2_delayed) = (n_CO2_target - n_CO2_delayed) / T;
  else
    n_H2_delayed = n_H2_target;
    n_CO2_delayed = n_CO2_target;
  end if;

  // Outputs
  n_H2_out = n_H2_delayed;
  n_CO2_out = n_CO2_delayed;

  annotation (uses(Modelica(version="4.0.0")));
end MethanationControlInput;
