within ;
model System_Test_1
  MethanationReactor methanationReactor
    annotation (Placement(transformation(extent={{118,30},{196,108}})));
  MethanationControlInput methanationControlInput(stoichRatio=8, T=0)
    annotation (Placement(transformation(extent={{-4,30},{74,108}})));
  TANDEM.H2production.HTSE.HTSE_module_steam hTSE_module(N_boiler=1)        annotation (Placement(transformation(extent={{-116,40},
            {-76,80}})));
  Modelica.Blocks.Sources.Ramp H2_ramp(
    height=0.1,
    duration=500,
    startTime=500)
    annotation (Placement(transformation(extent={{-194,104},{-174,124}})));
  Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(
    definiteReference=true,
    f=50,
    V=380000)
    annotation (Placement(transformation(extent={{-208,14},{-180,40}})));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource fuel(
    T0=fill(600, N_boiler),
    W0=fill(HeatSource_W/N_boiler, N_boiler),
    option_temperature=2)
    annotation (Placement(transformation(extent={{-122,176},{-102,196}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe     rampe2(
    Starttime=500,
    Duration=500,
    Initialvalue=0,
    Finalvalue=HeatSource_W/N_boiler)
    annotation (Placement(transformation(extent={{-166,186},{-146,206}})));
equation
  connect(methanationControlInput.n_H2_out,methanationReactor. n_H2_in)
    annotation (Line(points={{77.9,88.5},{114.1,88.5}}, color={0,0,127}));
  connect(methanationControlInput.n_CO2_out,methanationReactor. n_CO2_in)
    annotation (Line(points={{77.9,49.5},{114.1,49.5}}, color={0,0,127}));
  connect(hTSE_module.H2_target,H2_ramp. y) annotation (Line(points={{-119.2,74},
          {-168,74},{-168,114},{-173,114}},              color={0,0,127}));
  connect(fixVol.terminal,hTSE_module. term_n) annotation (Line(points={{-180,27},
          {-130,27},{-130,48},{-120,48}},                     color={0,120,120}));
  connect(fuel.ISignal,rampe2. y) annotation (Line(points={{-112,191},{-112,200},
          {-140,200},{-140,196},{-145,196}},
                              color={0,0,255}));
  connect(hTSE_module.H2_production, methanationControlInput.m_H2_in)
    annotation (Line(points={{-73.6,74},{-16,74},{-16,72.9},{-7.9,72.9}}, color
        ={0,0,127}));
  connect(fuel.C, hTSE_module.extHeat) annotation (Line(points={{-112,176.2},{
          -104,176.2},{-104,104},{-96,104},{-96,80}}, color={0,0,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    uses(
      Modelica(version="4.0.0"),
      Buildings(version="11.0.0"),
      ThermoSysPro(version="4.0")));
end System_Test_1;
