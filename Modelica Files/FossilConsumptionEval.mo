within ;
model FossilConsumptionEval
  parameter Real efficiency = 0.8; //fattore che tiene conto di efficienza dei generatori termici e di perdite di sistema
  Modelica.Blocks.Interfaces.RealInput power_demand
    annotation (Placement(transformation(extent={{-140,-20},{-100,22}})));
  Modelica.Blocks.Interfaces.RealInput mass_flow_rate_required
    annotation (Placement(transformation(extent={{80,-20},{120,22}})));
  Modelica.Blocks.Interfaces.RealInput LHV annotation (Placement(transformation(
        extent={{-20,-21},{20,21}},
        rotation=90,
        origin={0,-121})));

equation
  mass_flow_rate_required = power_demand  / (LHV*efficiency);
  annotation (uses(Modelica(version="4.0.0")));
end FossilConsumptionEval;
