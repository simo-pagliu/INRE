within ;
model MethanationReactor
  import SI = Modelica.Units.SI;
  import Modelica.Blocks.Interfaces.RealInput;
  import Modelica.Blocks.Interfaces.RealOutput;

  // Parameters
  parameter SI.Volume V = 0.01 "Reactor volume [m^3]";
  parameter SI.Temperature T = 573.15 "Reactor temperature [K]";
  parameter SI.Pressure p = 1e5 "Operating pressure [Pa]";
  parameter Real A = 1e10 "Pre-exponential factor [mol/(m^3.s)]";
  parameter Real Ea = 100000 "Activation energy [J/mol]";
  parameter Real conversionEfficiency = 0.80 "CO2+H2 conversion efficiency";

  // Inputs: molar flow rates [mol/s]
  RealInput n_H2_in "Inlet molar flow rate of H2"
    annotation (Placement(transformation(extent={{-120,40},{-100,60}})));
  RealInput n_CO2_in "Inlet molar flow rate of CO2"
    annotation (Placement(transformation(extent={{-120,-60},{-100,-40}})));

  // Outputs
  RealOutput PCI "Lower calorific value [MJ/kg]"
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  RealOutput m_flow_rate "Total gas mass flow rate [kg/s] (CO2+CH4+H2)"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));

  // Constants
  constant Real R = 8.314 "Gas constant [J/mol.K]";
  constant Real M_CH4 = 16.0 "CH4 molar mass [g/mol]";
  constant Real M_CO2 = 44.0 "CO2 molar mass [g/mol]";
  constant Real M_H2  = 2.0  "H2 molar mass [g/mol]";
  constant Real LHV_CH4 = 50.0 "CH4 PCI [MJ/kg]";
  constant Real LHV_H2  = 120.0 "H2 PCI [MJ/kg]";

  // Internal variables
  Real n_CH4_out, n_H2_out, n_CO2_out;
  Real m_CH4_out, m_H2_out, m_CO2_out;

  // Temporary variable
  Real CH4_formed;

algorithm
  // Apply conversion based on limiting reactant
  CH4_formed := min(n_CO2_in, n_H2_in / 4) * conversionEfficiency;

  // Remaining molar flows (after conversion)
  n_CH4_out := CH4_formed;
  n_H2_out  := max(n_H2_in - 4 * CH4_formed, 0);
  n_CO2_out := max(n_CO2_in - 1 * CH4_formed, 0);

  // Mass flow rate [kg/s]
  m_CH4_out := n_CH4_out * M_CH4 / 1000;
  m_H2_out  := n_H2_out  * M_H2  / 1000;
  m_CO2_out := n_CO2_out * M_CO2 / 1000;

  m_flow_rate := m_CH4_out + m_H2_out + m_CO2_out;

  // Lower calorific value [MJ/kg]
  PCI := (m_CH4_out * LHV_CH4 + m_H2_out * LHV_H2) / m_flow_rate;

  annotation (uses(Modelica(version="4.0.0")));
end MethanationReactor;
