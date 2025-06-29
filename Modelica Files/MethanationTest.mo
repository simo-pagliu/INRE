within ;
model MethanationTest

  MethanationReactor methanationReactor
    annotation (Placement(transformation(extent={{22,22},{100,100}})));
  Modelica.Blocks.Sources.Ramp H2_prod(
    height=0.25,
    duration=3,
    offset=1,
    startTime=1)
    annotation (Placement(transformation(extent={{-174,46},{-136,84}})));
  MethanationControlInput methanationControlInput(stoichRatio=8, T=0)
    annotation (Placement(transformation(extent={{-100,22},{-22,100}})));
equation
  connect(methanationControlInput.n_H2_out, methanationReactor.n_H2_in)
    annotation (Line(points={{-18.1,80.5},{18.1,80.5}}, color={0,0,127}));
  connect(methanationControlInput.n_CO2_out, methanationReactor.n_CO2_in)
    annotation (Line(points={{-18.1,41.5},{18.1,41.5}}, color={0,0,127}));
  connect(H2_prod.y, methanationControlInput.m_H2_in) annotation (Line(points={
          {-134.1,65},{-112,65},{-112,64.9},{-103.9,64.9}}, color={0,0,127}));
  annotation (uses(Modelica(version="4.0.0")), experiment(StopTime=10,
        __Dymola_Algorithm="Dassl"));
end MethanationTest;
