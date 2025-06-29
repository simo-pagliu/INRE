within ;
model Control_Room

  parameter Real threshold = 1e6;
  parameter Real min_turb_load = 0.35;
  parameter Real turbine_ramp_up = 1e6;
  parameter Real turbine_ramp_down = 1e6;
  parameter Real P_min_HTSE = 0.6*20e6;
  parameter Real P_nom_turb = 57e6;

  Real A(start = 0);
  Real P_t(start = 0);

  Modelica.Blocks.Interfaces.RealInput P_nuc
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput P_turbine
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput Demand
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealInput P_HTSE
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput setpoint_H2
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput mflow_tapSteam
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));


  Modelica.Blocks.Interfaces.RealOutput turbine_load
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));


equation
  A = P_nuc + P_turbine - P_HTSE - Demand - P_min_HTSE;
  der(P_t) = if A > threshold and P_turbine/P_nom_turb > min_turb_load then
             -turbine_ramp_down
           else if A <= threshold then
             turbine_ramp_up
           else
             0;
  turbine_load = (P_t+P_turbine)/P_nom_turb;
  setpoint_H2 = (1/21.4)*((A + P_min_HTSE)/1e7 + 0.197775);
  mflow_tapSteam = 1;

 annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Bitmap(extent={{
              -96,-102},{96,106}}, fileName="modelica://Control_Room/../Project/Control_Room.jpg")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    uses(Modelica(version="4.0.0")));

end Control_Room;
