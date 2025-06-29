within ;
model System_Test_3

  sette_laghi.MethanationReactor methanationReactor(conversionEfficiency=0.8)
    annotation (Placement(transformation(extent={{154,-62},{232,16}})));
  sette_laghi.MethanationControlInput methanationControlInput(stoichRatio=8, T=
        0) annotation (Placement(transformation(extent={{32,-62},{110,16}})));
  sette_laghi.Turbina
          turbina
    annotation(Placement(transformation(extent={{480,-214},{632,-80}})));
  ThermoSysPro.Fluid.Combustion.BoundaryConditions.FuelSourcePQ fuelSourcePQ(P0=100000)
    annotation(Placement(transformation(extent={{576,-48},{642,18}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ sourcePQ1(
    P0=100000,
    Q0=0,
    T0=288.15,
    option_temperature=true,
    continuous_flow_reversal=false,
    diffusion=false)
    annotation(Placement(transformation(extent={{338,-128},{404,-58}})));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ sourcePQ2(
    P0=100000,
    Q0=100,
    T0=293.15,
    option_temperature=true,
    continuous_flow_reversal=false,
    diffusion=false)
    annotation(Placement(transformation(extent={{276,-208},{368,-122}})));
  sette_laghi.Generatore
             generatore
    annotation(Placement(transformation(extent={{774,-228},{908,-94}})));
  ThermoSysPro.InstrumentationAndControl.AdaptorForFMU.AdaptorModelicaTSP
    adaptorModelicaTSP
    annotation (Placement(transformation(extent={{348,-20},{368,0}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante constante
    annotation (Placement(transformation(extent={{536,-38},{572,-16}})));
  sette_laghi.Buffer                               bufferH2
    annotation (Placement(Placement(transformation(extent={{0,20},{0,15}})),
        transformation(extent={{-60,32},{-2,-26}})));
  sette_laghi.Buffer
         bufferCH4 annotation (Placement(Placement(transformation(extent={{0,
              20},{0,15}})), transformation(extent={{268,-2},{324,-58}})));
  TANDEM.H2production.HTSE.HTSE_module_steam hTSE_module(
    N_boiler=N_boiler,
    HTSE_Module(physical(SOEC(I_dens(start={1.7349368133702872E-12,-2.907824063542754E-13,
                -1.6837860310990185E-13,-1.9070925936537576E-12,-2.6488761452193666E-13,
                2.8351831549383187E-13,-1.8121990508568652E-12,-9.804395922269622E-13,
                -6.429748903638031E-13,-7.574463253835338E-13,
                1.4658842390048005E-12,-1.4835753687399038E-13,
                1.397440159018875E-12,3.066221294869167E-13,
                1.1377665868813206E-13,-6.902027107898186E-13,
                1.018866919669321E-12,-2.8204591117844256E-13,
                3.2923115697334835E-13,1.294530843607775E-12}), cat_out_port(
              Xi_outflow(start={0.7460201743080869,0.2539798256919132,0.0}))))),

    bOP_module(
      Q_control(Limiteur1(u(signal(start=-0.6949815112735434)))),
      T_control1(Limiteur1(u(signal(start=0)))),
      Wall_HR_HT(Tp(start={592.7125759267673,734.7685584214644,
              874.9668675005843}, displayUnit="degC")),
      Wall_HR_LT(Tp(start={349.53252118734264,370.5019912369099,
              394.9486808241491}, displayUnit="degC")),
      boiler(mu2(start={0.0002639658269909485,0.0002639658269887603,
              0.00026396582698657277,0.00026396582698438354}), pro2(d(start={
                953.8427646724637,953.8427646706349,953.842764668806,
                953.8427646669775}, displayUnit="g/cm3"))),
      eHeater(Xco2(start=1.4349761869549854E-21), Xo2(start=
              5.492202735844653E-21)),
      heatRecoverHT_h(
        Tp(start={874.9688374773776,734.7704844573645,592.7144368998412},
            displayUnit="degC"),
        mu2(start={3.340865766321351E-05,2.9564288724101522E-05,
              2.53857720045527E-05,2.0888413596565884E-05}),
        rho2(start={0.19296384360584978,0.22243365457070166,0.2634359770302942,
              0.3235158377943518}, displayUnit="g/cm3")),
      heatRecoverHT_w(
        Tp(start={592.7106781003563,734.7665942437711,874.9648585118246},
            displayUnit="degC"),
        mu2(start={1.4619833608225352E-05,1.967117033420077E-05,
              2.4441267776878306E-05,2.8809737361566745E-05}),
        rho2(start={0.46187725237433885,0.34396030090900304,0.27441541430546795,
              0.22904962507533666}, displayUnit="g/cm3")),
      heatRecoverLT_h(
        Tp(start={395.0826752296174,370.6171455983306,349.6321339501858},
            displayUnit="degC"),
        mu2(start={2.0888413596565884E-05,1.9435845192721382E-05,
              1.8154846788314828E-05,1.702428712645801E-05}),
        rho2(start={0.32351583632551945,0.3481798495766646,0.3728964186071958,
              0.39755101319067637}, displayUnit="g/cm3")),
      heatRecoverLT_w(mu2(start={0.0005689308455769882,0.0004364888736089875,
              0.0003378354242207914,0.00026396582702939794}), pro2(d(start={
                989.2534559563586,981.0104844938994,969.5041256174329,
                953.8427647045903}, displayUnit="g/cm3"))),
      mixing(
        Xco2(start=1.4349761869549854E-21),
        Xo2(start=5.492202735844653E-21),
        h(start=2785128.9513046555)),
      sPloss3(rho(start=0.4618772530752241, displayUnit="g/cm3")),
      sensorQ(C1(h_vol(start=632170.3273848991))),
      volumeBoiler(h(start=632170.3273848991)),
      wPloss1(C1(h_vol(start=446402.48690976296)), C2(h_vol(start=
                446402.48690976296)))))                                                   annotation (Placement(transformation(extent={{-182,4},
            {-142,44}})));
  Modelica.Blocks.Sources.Ramp H2_ramp(
    height=0.1,
    duration=500,
    startTime=500)
    annotation (Placement(transformation(extent={{-236,38},{-216,58}})));
  Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(
    definiteReference=true,
    f=50,
    V=380000)
    annotation (Placement(transformation(extent={{-264,-14},{-236,12}})));
  ThermoSysPro.Thermal.BoundaryConditions.HeatSource fuel(
    T0=fill(600, N_boiler),
    W0=fill(HeatSource_W/N_boiler, N_boiler),
    option_temperature=2)
    annotation (Placement(transformation(extent={{-172,84},{-152,104}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe     rampe1(
    Starttime=500,
    Duration=500,
    Initialvalue=0,
    Finalvalue=HeatSource_W/N_boiler)
    annotation (Placement(transformation(extent={{-216,94},{-196,114}})));
equation
  connect(methanationControlInput.n_H2_out,methanationReactor. n_H2_in)
    annotation (Line(points={{113.9,-3.5},{150.1,-3.5}},color={0,0,127}));
  connect(methanationControlInput.n_CO2_out,methanationReactor. n_CO2_in)
    annotation (Line(points={{113.9,-42.5},{150.1,-42.5}},
                                                        color={0,0,127}));
  connect(fuelSourcePQ.C,turbina. Entree_combustible)
    annotation(Line(points={{642,-15},{656,-15},{656,-70},{601.6,-70},{601.6,
          -80}},                                                            color={0,0,0}));
  connect(sourcePQ1.C,turbina. Entree_eau_combustion) annotation (Line(points={{404,-93},
          {468,-93},{468,-70},{510.4,-70},{510.4,-80}},   color={0,0,0}));
  connect(sourcePQ2.C,turbina. Entree_air)
    annotation(Line(points={{368,-165},{468,-165},{468,-147},{480,-147}},       color={0,0,0}));
  connect(turbina.PuissanceMeca,generatore. Wmec)
    annotation(Line(points={{635.04,-173.8},{756,-173.8},{756,-134.2},{774,
          -134.2}},                                                             color={0,0,255}));
  connect(methanationReactor.PCI,turbina. LHV_input) annotation (Line(points={{235.9,
          4.3},{256,4.3},{256,10},{392,10},{392,-46},{524,-46},{524,-58},{
          553.72,-58},{553.72,-79.33}},                          color={0,0,127}));
  connect(adaptorModelicaTSP.outputReal,fuelSourcePQ. IMassFlow) annotation (
      Line(points={{369,-10},{564,-10},{564,32},{609,32},{609,1.5}},  color={0,0,
          255}));
  connect(constante.y,fuelSourcePQ. IPressure) annotation (Line(points={{573.8,
          -27},{592.5,-27},{592.5,-15}},
                                  color={0,0,255}));
  connect(bufferH2.mass_flow_out,methanationControlInput. m_H2_in)
    annotation (Line(points={{0.61,1.55},{20,1.55},{20,-19.1},{28.1,-19.1}},
        color={0,0,127}));
  connect(bufferCH4.mass_flow_out,adaptorModelicaTSP. u) annotation (Line(
        points={{326.52,-31.4},{326.52,-10},{346,-10}},
                                                     color={0,0,127}));
  connect(methanationReactor.m_flow_rate,bufferCH4. mass_flow_in) annotation (
     Line(points={{235.9,-3.5},{235.9,-31.12},{265.76,-31.12}},
                                                              color={0,0,127}));
  connect(hTSE_module.H2_target,H2_ramp. y) annotation (Line(points={{-185.2,38},
          {-210,38},{-210,48},{-215,48}},                color={0,0,127}));
  connect(fixVol.terminal,hTSE_module. term_n) annotation (Line(points={{-236,-1},
          {-192,-1},{-192,12},{-186,12}},                     color={0,120,120}));
  connect(fuel.ISignal,rampe1. y) annotation (Line(points={{-162,99},{-162,108},
          {-190,108},{-190,104},{-195,104}},
                              color={0,0,255}));
  connect(fuel.C,hTSE_module. extHeat)
    annotation (Line(points={{-162,84.2},{-162,44}},
                                                  color={0,0,0}));
  connect(hTSE_module.H2_production, bufferH2.mass_flow_in) annotation (Line(
        points={{-139.6,38},{-84,38},{-84,1.84},{-62.32,1.84}}, color={0,0,127}));
  connect(hTSE_module.H2_production, bufferH2.demand) annotation (Line(points={
          {-139.6,38},{-84,38},{-84,21.56},{-64.64,21.56}}, color={0,0,127}));
  connect(methanationReactor.m_flow_rate, bufferCH4.demand) annotation (Line(
        points={{235.9,-3.5},{244,-3.5},{244,-12.08},{263.52,-12.08}}, color={0,
          0,127}));
  annotation (uses(
      ThermoSysPro(version="4.0"),
      Modelica(version="4.0.0"),
      Buildings(version="11.0.0")));
end System_Test_3;
