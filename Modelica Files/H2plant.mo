within ;
model H2plant
  parameter Real N_HTSE;
  TANDEM.H2production.HTSE.HTSE_module_steam hTSE_module(
    N_boiler=N_boiler,
    HTSE_Module(physical(SOEC(I_dens(start={1.7349368133702872E-12,-2.907824063542754E-13,
                -1.6837860310990185E-13,-1.9070925936537576E-12,-2.6488761452193666E-13,
                2.8351831549383187E-13,-1.8121990508568652E-12,-9.804395922269622E-13,
                -6.429748903638031E-13,-7.574463253835338E-13,1.4658842390048005E-12,
                -1.4835753687399038E-13,1.397440159018875E-12,3.066221294869167E-13,
                1.1377665868813206E-13,-6.902027107898186E-13,1.018866919669321E-12,
                -2.8204591117844256E-13,3.2923115697334835E-13,1.294530843607775E-12}),
            cat_out_port(Xi_outflow(start={0.7460201743080869,0.2539798256919132,
                  0.0}))))),
    bOP_module(
      Q_control(Limiteur1(u(signal(start=-0.6949815112735434)))),
      T_control1(Limiteur1(u(signal(start=0)))),
      Wall_HR_HT(Tp(start={592.7125759267673,734.7685584214644,874.9668675005843},
            displayUnit="degC")),
      Wall_HR_LT(Tp(start={349.53252118734264,370.5019912369099,394.9486808241491},
            displayUnit="degC")),
      boiler(mu2(start={0.0002639658269909485,0.0002639658269887603,0.00026396582698657277,
              0.00026396582698438354}), pro2(d(start={953.8427646724637,953.8427646706349,
                953.842764668806,953.8427646669775}, displayUnit="g/cm3"))),
      eHeater(Xco2(start=1.4349761869549854E-21), Xo2(start=5.492202735844653E-21)),
      heatRecoverHT_h(
        Tp(start={874.9688374773776,734.7704844573645,592.7144368998412},
            displayUnit="degC"),
        mu2(start={3.340865766321351E-05,2.9564288724101522E-05,2.53857720045527E-05,
              2.0888413596565884E-05}),
        rho2(start={0.19296384360584978,0.22243365457070166,0.2634359770302942,0.3235158377943518},
            displayUnit="g/cm3")),
      heatRecoverHT_w(
        Tp(start={592.7106781003563,734.7665942437711,874.9648585118246},
            displayUnit="degC"),
        mu2(start={1.4619833608225352E-05,1.967117033420077E-05,2.4441267776878306E-05,
              2.8809737361566745E-05}),
        rho2(start={0.46187725237433885,0.34396030090900304,0.27441541430546795,
              0.22904962507533666}, displayUnit="g/cm3")),
      heatRecoverLT_h(
        Tp(start={395.0826752296174,370.6171455983306,349.6321339501858},
            displayUnit="degC"),
        mu2(start={2.0888413596565884E-05,1.9435845192721382E-05,1.8154846788314828E-05,
              1.702428712645801E-05}),
        rho2(start={0.32351583632551945,0.3481798495766646,0.3728964186071958,0.39755101319067637},
            displayUnit="g/cm3")),
      heatRecoverLT_w(mu2(start={0.0005689308455769882,0.0004364888736089875,0.0003378354242207914,
              0.00026396582702939794}), pro2(d(start={989.2534559563586,981.0104844938994,
                969.5041256174329,953.8427647045903}, displayUnit="g/cm3"))),
      mixing(
        Xco2(start=1.4349761869549854E-21),
        Xo2(start=5.492202735844653E-21),
        h(start=2785128.9513046555)),
      sPloss3(rho(start=0.4618772530752241, displayUnit="g/cm3")),
      sensorQ(C1(h_vol(start=632170.3273848991))),
      volumeBoiler(h(start=632170.3273848991)),
      wPloss1(C1(h_vol(start=446402.48690976296)), C2(h_vol(start=446402.48690976296))))) annotation (Placement(transformation(extent={{-18,-48},
            {22,-8}})));

  Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(
    definiteReference=true,
    f=50,
    V=380000)
    annotation (Placement(transformation(extent={{-80,-84},{-52,-58}})));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource fuel(
    T0=fill(600, N_boiler),
    W0=fill(HeatSource_W/N_boiler, N_boiler),
    option_temperature=2)
    annotation (Placement(transformation(extent={{-12,20},{8,40}})));
  Modelica.Blocks.Sources.RealExpression heat2HTSE(y=HX_cog_IP.Hx_Hybrid.W/
        N_boiler)
    annotation (Placement(transformation(extent={{55,-19},{-55,19}},
        rotation=90,
        origin={-41,255})));
  ThermoSysPro.InstrumentationAndControl.AdaptorForFMU.AdaptorModelicaTSP
    adaptorModelicaTSP
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,66})));
  Modelica.Blocks.Math.Division division annotation (Placement(transformation(
        extent={{18,-18},{-18,18}},
        rotation=90,
        origin={-70,76})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{82,-8},{102,12}})));
  Modelica.Blocks.Math.Division division1 annotation (Placement(transformation(
        extent={{21,-21},{-21,21}},
        rotation=180,
        origin={51,145})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=N_HTSE)
                                                             annotation (
      Placement(transformation(
        extent={{-41,-19},{41,19}},
        rotation=-90,
        origin={-79,257})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=N_HTSE)
                                                              annotation (
      Placement(transformation(
        extent={{-41,-19},{41,19}},
        rotation=-90,
        origin={129,165})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=N_HTSE)
                                                              annotation (
      Placement(transformation(
        extent={{-41,-19},{41,19}},
        rotation=-90,
        origin={39,253})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=0.2,
    duration=500,
    offset=0,
    startTime=10)
    annotation (Placement(transformation(extent={{-198,190},{-178,210}})));
  Modelica.Blocks.Math.Gain gain
    annotation (Placement(transformation(extent={{-282,272},{-262,292}})));
  Modelica.Blocks.Math.Gain gain1
    annotation (Placement(transformation(extent={{-194,112},{-174,132}})));
equation
  connect(fixVol.terminal,hTSE_module. term_n) annotation (Line(points={{-52,-71},
          {-52,-72},{-32,-72},{-32,-40},{-22,-40}},           color={0,120,120}));
  connect(fuel.C,hTSE_module. extHeat)
    annotation (Line(points={{-2,20.2},{-2,0},{2,0},{2,-8}},
                                                  color={0,0,0}));
  connect(adaptorModelicaTSP.outputReal,fuel. ISignal) annotation (Line(
        points={{0,55},{0,46},{-2,46},{-2,35}},                       color={
          0,0,255}));
  connect(adaptorModelicaTSP.u,division1. y) annotation (Line(points={{0,78},{0,
          118},{82,118},{82,145},{74.1,145}},         color={0,0,127}));
  connect(hTSE_module.H2_production,product1. u2) annotation (Line(points={{24.4,
          -14},{70,-14},{70,-4},{80,-4}},  color={0,0,127}));
  connect(product1.u1,realExpression1. y) annotation (Line(points={{80,8},{72,8},
          {72,110},{129,110},{129,119.9}},         color={0,0,127}));
  connect(division.y,hTSE_module. H2_target) annotation (Line(points={{-70,56.2},
          {-70,-14},{-21.2,-14}},         color={0,0,127}));
  connect(heat2HTSE.y,division1. u1) annotation (Line(points={{-41,194.5},{16,194.5},
          {16,132.4},{25.8,132.4}},                                color={0,0,
          127}));
  connect(division1.u2,realExpression2. y) annotation (Line(points={{25.8,157.6},
          {18,157.6},{18,198},{39,198},{39,207.9}},             color={0,0,
          127}));
  connect(realExpression.y,division. u2) annotation (Line(points={{-79,211.9},{-80,
          211.9},{-80,106},{-59.2,106},{-59.2,97.6}},       color={0,0,127}));
  connect(ramp1.y,division. u1) annotation (Line(points={{-177,200},{-82,200},{-82,
          104},{-80.8,104},{-80.8,97.6}},
                                color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    uses(
      Buildings(version="11.0.0"),
      ThermoSysPro(version="4.0"),
      Modelica(version="4.0.0")));
end H2plant;
