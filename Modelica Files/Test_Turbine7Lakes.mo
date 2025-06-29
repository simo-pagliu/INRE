within ;
model Test_Turbine7Lakes
  ThermoSysPro.ElectroMechanics.Machines.Generator generator
    annotation (Placement(transformation(extent={{178,-218},{294,-102}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante(k=
        0.93)
    annotation (Placement(transformation(extent={{-304,42},{-228,118}})));
  ThermoSysPro.Fluid.Machines.GasTurbine gasTurbine
    annotation (Placement(transformation(extent={{-76,-70},{76,64}})));
  ThermoSysPro.Fluid.Combustion.BoundaryConditions.FuelSourcePQ fuelSourcePQ
    annotation (Placement(transformation(extent={{-12,96},{54,162}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ sourcePQ
    annotation (Placement(transformation(extent={{-134,92},{-68,162}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ sourcePQ1
    annotation (Placement(transformation(extent={{-280,-74},{-188,12}})));
equation
  connect(constante.y, gasTurbine.Huminide) annotation (Line(points={{-224.2,80},
          {-88,80},{-88,37.2},{-79.04,37.2}}, color={0,0,255}));
  connect(gasTurbine.PuissanceMeca, generator.Wmec3) annotation (Line(points={{
          79.04,-29.8},{164,-29.8},{164,-160},{178,-160}}, color={0,0,255}));
  connect(fuelSourcePQ.C, gasTurbine.Entree_combustible) annotation (Line(
        points={{54,129},{52,129},{52,92},{45.6,92},{45.6,64}}, color={0,0,0}));
  connect(sourcePQ.C, gasTurbine.Entree_eau_combustion) annotation (Line(points
        ={{-68,127},{-45.6,127},{-45.6,64}}, color={0,0,0}));
  connect(sourcePQ1.C, gasTurbine.Entree_air) annotation (Line(points={{-188,
          -31},{-188,-32},{-86,-32},{-86,-3},{-76,-3}}, color={0,0,0}));
  annotation (uses(ThermoSysPro(version="4.0")));
end Test_Turbine7Lakes;
