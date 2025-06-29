within ;
model Trial2_project

  inner ThermoPower.System system(initOpt=ThermoPower.Choices.Init.Options.steadyState)
    annotation (Placement(transformation(extent={{48,22},{68,42}})));
  ThermoPower.Water.SinkMassFlow sinkMassFlow1 annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={-233,-73})));
  ThermoPower.Water.SinkMassFlow sinkMassFlow2 annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={-243,-83})));
  ThermoPower.Water.SinkMassFlow sinkMassFlow3 annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={-235,-95})));
  ThermoPower.Water.SourceMassFlow sourceMassFlow1
                                                  annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={-31,-61})));
  ThermoPower.Water.SourceMassFlow sourceMassFlow3 annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={-63,-81})));
  ThermoPower.Water.SourceMassFlow sourceMassFlow4 annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={-69,-95})));
  TANDEM.SMR.BOP.BOP_POLIMI.BOPdyn_fluid
                                  bop(
    CNDpump(
      dp(start=833877.7657041976, displayUnit="bar"),
      q_single(start=0.18342285826758592),
      h(start=164415.6813323274)),
    FWpump(
      h(start=490330.41391457524),
      inletFluidState(h(start=485023.5586959611), p(start=674700.0, displayUnit
            ="bar")),
      q_single(start=0.2537596280731338),
      dp(start=4020186.4566965904, displayUnit="bar"),
      w(start=239.68)),
    FWtank(hout(start=485023.5586959611), inlet(m_flow(start={
              182.70645504180732,21.359445946788938,11.585945991523744,
              24.63970343113134,0.0}))),
    HPTurbine(eta_iso(start=0.8724406950760611), Kt=0.024296397),
    HP_TAV(
      dp(start=111129.59382432606, displayUnit="bar"),
      outlet(p(start=4388870.406175674, displayUnit="bar")),
      fluidState(d(start=19.46395772220656, displayUnit="g/cm3"))),
    Kv_RHin(dp(start=50000.0, displayUnit="bar")),
    LPTurbine1(
      eta_iso(start=0.8915013737343765),
      steamState_in(p(start=603691.5946386852, displayUnit="bar")),
      Kt=0.1422814),
    LPTurbine2(
      eta_iso(start=0.8461104331399771),
      steamState_in(p(start=78958.1731573167, displayUnit="bar")),
      Kt=0.8519112),
    LP_TAV(dp(start=50875.2576437986, displayUnit="bar"), fluidState(d(start=
              4.19282303283765, displayUnit="g/cm3"))),
    LP_TAV1(dp(start=1141.8268426832947, displayUnit="bar"), fluidState(d(start
            =0.4872827478544918, displayUnit="g/cm3"))),
    flangeA1(m_flow(start=18.122)),
    hp_fw(shell_2ph(h(start={2640029.835471013,2584543.6810958125,
              2514502.077218182,2426105.003582753,2314574.398228231,
              2173914.1525072837,1996621.8969125538,1773353.7657721057,
              1492557.392171137,1140120.5685454889,702080.1763842385}), p(start
            =754700.0, displayUnit="bar")), flangeB1(h_outflow(start=
              690767.5833675114))),
    lp_fw(shell_2ph(h(start={2622324.0773632796,2557740.7614028677,
              2475459.0238973573,2370746.604587442,2237688.2987339273,
              2068951.7930747226,1855558.8511910771,1586719.0032877019,
              1249845.8934813505,830999.3886825964,337776.57197170355}), p(
            start=80100.0, displayUnit="bar"))),
    mixer(h(start=2762979.0107021905)),
    moistureSeparator(inlet(p(start=703824.7423562014, displayUnit="bar")),
        steam(h_outflow(start=2762979.0107021914))),
    pressDropLin3(state(d(start=902.3493544120743, displayUnit="g/cm3"))),
    rh(shell_2ph(h(start={2944106.364303575,2891534.221268932,2856402.468476426,
              2832476.468343672,2815962.662042598,2780851.336196795,
              2707451.350891653,2572382.19700998,2325075.342361329,
              1875784.4336333664,1073418.7138238868}), p(start=4450000.0,
            displayUnit="bar")), hshell=1200),
    velveRH(dp(start=3735300.0, displayUnit="bar")),
    mixer2(h(start=690767.5833675114), p(start=4640000.0, displayUnit="bar")),
    valveLiq(dp(start=40000.0, displayUnit="bar")),
    valveLiq1(dp(start=73100.0, displayUnit="bar")),
    valve_SGin(dp(start=100467.18061794766, displayUnit="bar")),
    sensT1_2(T(start=573.15, fixed=false)),
    flangeB2(h_outflow(start=2944106.364303575)))
    annotation (Placement(transformation(extent={{-172,-32},{-38,34}})));
  ThermoPower.Electrical.Load load(Pnom=170e6, usePowerInput=true)
    annotation (Placement(transformation(extent={{-8,-22},{-28,-2}})));
  ThermoPower.Electrical.FrequencySensor frequencySensor annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-18,24})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=bop.powerSensor.power)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={18,-14})));
  TANDEM.SMR.BOP.BOP_POLIMI.Control.BOPcontroller_Cogeneration
                                     BOPctrl(
    PID1(limiter(u(start=-0.234844074605851)), gainPID(y(start=
              0.042442084759688664))),
    PID10(limiter(u(start=0.00021717055644652109)), gainPID(y(start=
              0.0002171705564670664))),
    PID2(limiter(u(start=0.35451515669346334)), gainPID(y(start=-0.016320135398980022))),
    PID3(limiter(u(start=0.06239140140385504)), gainPID(y(start=-0.025376969225241325))),
    PID4(limiter(u(start=-0.24685877822333424)), gainPID(y(start=-0.009367501596375971))),
    PID5(limiter(u(start=-0.5660324984937231)), gainPID(y(start=-0.06792489179693291))),
    PID6(
      limiter(u(start=0.008403237101311122)),
      y(start=0.002853972263941921),
      gainPID(y(start=0.002853972263941921))),
    PID7(limiter(u(start=-0.04851733604875657)), gainPID(y(start=-0.0007880353556956916))),
    PID8(limiter(u(start=-0.5372915325250245)), gainPID(y(start=-0.049476118564475875))),
    PID9(
      limiter(u(start=-0.01774698095579807)),
      y(start=5.727425174083511E-05),
      gainPID(y(start=5.727425174083511E-05))))
    annotation (Placement(transformation(extent={{-118,56},{-86,92}})));
  TANDEM.SMR.NSSS.NSSS_ThermoPower.Control.NSSSctrl_ex2
                       NSSSctrl(Qprop_max=0)
    annotation (Placement(transformation(extent={{-268,34},{-230,66}})));
  TANDEM.SMR.NSSS.NSSS_ThermoPower.NSSSsimplified_fluid nsss(
    htc2(start=14524.128572153119, fixed=false),
    core_dp=ThermoPower.Choices.Flow1D.FFtypes.Cfnom,
    dpnom(displayUnit="Pa") = 22280,
    Cfnom=0.0037,
    Primary_dp=ThermoPower.Choices.Flow1D.FFtypes.Cfnom,
    dp1=200000,
    Cfnom1=0.004,
    Secondary_dp=ThermoPower.Choices.Flow1D.FFtypes.Cfnom,
    dp2=40000,
    Cfnom2=0.0086448975,
    rho_sg(displayUnit="kg/m3"),
    eta=0.9,
    q_nom={0,0.85035195,1.51494276},
    head_nom={52.9277496,36.251883,0},
    hstart_pump=1.33804e6,
    dp0=257900,
    SG(Secondary(
        noInitialPressure=false,
        heatTransfer(gamma(start=14524.128572153179)),
        h(start={690767.5833675114,1065817.5606611941,1341910.4565328693,
              1585300.5475429283,1769347.528935335,1961746.5525623658,
              2195325.6844033995,2419340.8262498337,2620346.5606258777,
              2819716.380522984,2944106.3643035754}),
        p(start=4500000.0, displayUnit="bar")), Primary(p(start=
              14766823.51237794, displayUnit="bar"), wall(T(start={
                589.5798543578811,587.6813245928329,585.386741962809,
                583.1453819978965,583.7361717631809,580.0466186518124,
                577.748895952388,575.7213458726684,573.7592597044779,
                565.5945440714104}, displayUnit="degC")))),
    core(neutronicKinetics(P(start=540e6, fixed=true)), fuel(
        Tc(start={599.0286114453664,601.5824786501445,604.0987239344674,
              606.575378771239,609.0103867450403,611.4016010539939,
              613.7467771512207,616.0435568072992,618.2894389132003,
              620.4817319621259}, displayUnit="degC"),
        Tci(start={606.527405794192,609.0725385974999,611.580406104788,
              614.0490567503417,616.4764516587205,618.8604624086515,
              621.198864211474,623.4893208991174,625.729357140147,
              627.916312857987}, displayUnit="degC"),
        Tco(start={591.6413073379007,594.2057653218162,596.7326354544344,
              599.2199532925233,601.6656665061564,604.0676326269805,
              606.4236121762156,608.7312535407517,610.9880649823041,
              613.1913687172438}, displayUnit="degC"),
        Tvol(start=[1106.1817337516716,959.6502624329719,901.05757864716,
              846.4905377677868,794.9437138652278; 1109.1135981921248,
              962.2446428600508,903.519783443123,848.8315653563612,
              797.1720502327754; 1112.0053644780655,964.8033385022825,
              905.9480345482193,851.1402313857465,799.3695112885683;
              1114.8546133496652,967.3242181924355,908.3403132916303,
              853.41462004086,801.53427660192; 1117.6588186461465,
              969.8050566707356,910.6945119349208,855.6527310355208,
              803.6644455315426; 1120.415344353601,972.2435319764205,
              913.00843119995,857.8524772656381,805.7580349951837;
              1123.1214360688134,974.6372178979707,915.279773107156,
              860.0116780035341,807.812972995006; 1125.7742025487123,
              976.983567654174,917.5061254931355,862.1280441826093,
              809.8270846154616; 1128.370581875301,979.2798839720141,
              919.68493362259,864.1991514156156,811.7980663489667;
              1130.9072862941346,981.5232703122443,921.8134539167726,
              866.2223960171642,813.7234442508441], displayUnit="degC"),
        Tf(start=[1032.9159980923218,930.3539205400659,873.7740582074734,
              820.7171258165073,769.1703019139483; 1035.679120526088,
              932.8822131515869,876.1756743997421,823.0018077945683,
              771.3422926709825; 1038.4043514901741,935.3756865252509,
              878.5441329669829,825.2548713371574,773.4841512399793;
              1041.0894157710504,937.8322657420329,880.8774666662451,
              827.47444832139,775.5941048824501; 1043.731937658441,
              940.2497843028282,883.1736214852208,829.6585882835317,
              777.6703027795535; 1046.3294381650107,942.6259815881853,
              885.4304542327941,831.805256130411,779.7108138599565;
              1048.879326983392,944.9584955025633,887.645725555345,
              833.9123254992701,781.713620490742; 1051.378885101443,
              947.2448465736547,889.8170848378725,835.9775643990354,
              783.6766048318877; 1053.8252329236575,949.482408797302,
              891.9420425191029,837.9986088822911,785.5975238156423;
              1056.2152783031895,951.6683621145085,894.0179249669684,
              839.9729201340042,787.4739683676839], displayUnit="degC"))),
    flangeB(h_outflow(start=2944106.364303575)),
    pump(q_single(start=0.8497972368120889), h(start=1337675.626275881)),
    flangeA(h_outflow(start=1065817.5606611941)),
    pressurizer(pressurizer(h(start=1862126.0574145121))),
    Tavg(y(start=585.5, fixed=true)),
    rho0(start=0, fixed=false))
    annotation (Placement(transformation(extent={{-278,-18},{-220,18}})));
  ThermoPower.Water.PressDropLin
                             pressDropLin(R=0.5e5/27.366)
    annotation (Placement(transformation(extent={{-92,-156},{-82,-146}})));
  TANDEM.Tools.Thermal_Adaptor.TSPro2TP
                                 tSPro2TP(N=3) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={120,-170})));
  TANDEM.H2production.HTSE.HTSE_module_steam hTSE_module(HTSE_Module(physical(
          SOEC(
          I_dens(start={9.128309664762944E-13,4.885808768364177E-13,
                5.308137445264389E-13,-6.088958540968066E-13,-8.654919232105784E-13,
                -7.985297254260528E-13,-7.554228961330087E-13,
                1.5059839264188495E-12,2.0143230969625587E-13,
                6.088540785533174E-13,-8.886911009409284E-13,
                1.0537010174969696E-13,3.0289160185650334E-13,
                4.606790569856918E-13,-1.042643723830291E-12,-4.614927525260283E-13,
                2.070119425224505E-13,7.799537027557221E-13,-9.759144457548175E-14,
                -5.856428876384624E-13}),
          cat_out_port(Xi_outflow(start={0.9877195355076411,
                  0.012280464492358973,0.0})),
          x_H2O_TPBc(start={0.9,0.8999999999999999,0.8999999999999999,
                0.8999999999999999,0.8999999999999999,0.8999999999999999,
                0.8999999999999999,0.9000000000000001,0.8999999999999999,
                0.8999999999999999,0.8999999999999999,0.8999999999999999,
                0.8999999999999999,0.9000000000000001,0.9000000000000001,
                0.9000000000000001,0.9000000000000001,0.9000000000000001,
                0.8999999999999999,0.8999999999999999})))), bOP_module(
      SteamAdmission(Cv(start=68.04361329778757), Pm(start=299999.664178413,
            displayUnit="bar")),
      T_control1(Limiteur1(u(signal(start=-18.361930838221948)))),
      boiler(
        h(start={447569.78125,920805.8595298465,1327972.6660014242,
              1767984.4088843619,1767984.375}),
        mu2(start={0.00026323985245044033,1.2763180621059448E-05,
              1.3587885475631836E-05,1.385128296109206E-05}),
        pro2(d(start={953.6357459703731,19.668147278185607,8.128099206644334,
                4.974148381996606}, displayUnit="g/cm3")),
        Tp(start={469.2929451746213,489.84372618017295,508.5729244270464},
            displayUnit="degC")),
      eHeater(Xco2(start=-1.187258232552915E-19), Xo2(start=-3.2348585892668595E-20)),
      heatRecoverHT_h(Tp(start={875.375667970623,735.5677770548631,
              593.8999888053693}, displayUnit="degC"), h(start={4129711.75,
              3803187.730520326,3483915.041602621,3175364.456051064,3081397.0})),
      heatRecoverHT_w(h(start={2788599.75,3097150.444445348,3416423.1333630537,
              3742947.1357293334,4129711.75})),
      heatRecoverLT_h(h(start={3175364.5,3081396.906210107,3000659.991925449,
              2930834.944947381,2504774.5})),
      heatRecoverLT_w(h(start={200000.0,270693.1922149147,352433.9206122349,
              447569.78303360846,447569.78125})),
      mixing(Xco2(start=-1.187258232552915E-19), Xo2(start=-3.2348585892668595E-20)),
      sensorQ(C1(h_vol(start=1767984.4088843619))),
      volumeBoiler(h(start=1767984.4088843619)),
      wPloss1(Pm(start=499999.4730105689, displayUnit="bar"))))                           annotation (Placement(transformation(extent={{100,
            -232},{140,-192}})));
  Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(
    definiteReference=true,
    f=50,
    V=380000)
    annotation (Placement(transformation(extent={{40,-250},{64,-224}})));
  TANDEM.TestCases.EnergyHub.Components.IntermediateLoop
                              intermediateLoop_v2_1(
    Nmod=Nmod,
    SG(flangeB1(h_outflow(start=503914.33055430546)), shell_2ph(
        H=-1,
        h(start={2944106.364303575,2174900.5696926787,1951578.9414907715,
              1722878.8332976038,1488671.0327538224,1248823.2402928215,
              1091737.0379353226,1071764.5571369436,1080373.2596519985,
              1076643.6913871132,1078255.957690933}),
        p(start=4498384.0130193, displayUnit="bar"),
        wall(T(start={525.13627564014,523.0459709921382,522.8623328165717,
                522.6742827614781,522.4817154009111,522.0553030982863,
                521.561291409001,521.4696126184172,521.5091780637471,
                521.4920461360441}, displayUnit="degC")))),
    flangeB1(h_outflow(start=504204.4016247846)),
    flow1DFV1(infl(h_outflow(start=504204.4016247846)), p(start=
            823432.5499801105, displayUnit="bar"))) annotation (Placement(
        transformation(
        extent={{-26,-49},{26,49}},
        rotation=90,
        origin={19,-154})));
  ThermoPower.Water.Flow1DFV flow1DFV(
    redeclare package Medium =
        TANDEM.EnergyStorage.ThermalStorage.Media.Therminol66,
    N=4,
    Nt=100,
    L=10,
    A=pi*(0.04/2)^2,
    omega=pi*0.04,
    Dhyd=0.04,
    wnom=456.621/Nmod,
    pstart=700000,
    hstartin=503914,
    hstartout=394414,
    initOpt=ThermoPower.Choices.Init.Options.steadyState,
    noInitialPressure=false,
    fixedMassFlowSimplified=true,
    redeclare model HeatTransfer =
        ThermoPower.Thermal.HeatTransferFV.FlowDependentHeatTransferCoefficient
        (
        gamma_nom=2050,
        alpha=0.8,
        beta=0.01,
        sigma=0.01),
    p(start=773495.44213731, displayUnit="bar"),
    htilde(start={460786.63127783616,420609.80595451925,373913.6534632445}))
                   annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={92,-154})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=hTSE_module.bOP_module.boiler.C2.h)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={94,-84})));
  TANDEM.TestCases.EnergyHub.Control.ILcontroller
                       iLcontroller(
    const(k=2.8e6),
    gain1(k=1/2.8e6),
    PID3(
      yMax=-0.01,
      yMin=-0.96,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=-0.96,
      homotopyType=Modelica.Blocks.Types.LimiterHomotopy.LowerLimit,
      strict=true),
    PID(
      yMin=-0.97,
      initType=Modelica.Blocks.Types.Init.SteadyState,
      y_start=-0.98,
      homotopyType=Modelica.Blocks.Types.LimiterHomotopy.LowerLimit,
      strict=true,
      gainPID(y(start=-0.9680935503695982)))) annotation (Placement(
        transformation(
        extent={{33,-19},{-33,19}},
        rotation=0,
        origin={19,-99})));
  TANDEM.PowerSources.SimpleCHP chp
    annotation (Placement(transformation(extent={{78,114},{128,156}})));
  TANDEM.PowerSources.Control.CHP_controller
                                      cHP_controller(
    Pnom_th=0,
    Pnom_el=Pmax_CCGT,
    Pmin_th=0,
    Pmin_el=0,
    PowerLoss=1,
    RampUp=0.05,
    RampDown=0.05)
    annotation (Placement(transformation(extent={{-98,154},{-62,188}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-152,132},{-132,152}})));
  Modelica.Blocks.Math.Gain gain1(k=1/eff_CCGT)
    annotation (Placement(transformation(extent={{274,162},{294,182}})));
  ThermoPower.Electrical.Grid grid(Pgrid=90e6)
    annotation (Placement(transformation(extent={{152,144},{172,164}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=283.15)
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={166,126})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{170,-348},{190,-328}})));
  Modelica.Blocks.Continuous.Integrator integrator(initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=SOCstart*H2Storage)
    annotation (Placement(transformation(extent={{220,-356},{256,-320}})));
  Modelica.Blocks.Math.Gain gain(k=1/H2Storage)
    annotation (Placement(transformation(extent={{282,-348},{302,-328}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=nsss.core.Power)
    annotation (Placement(transformation(extent={{190,72},{250,118}})));
  Modelica.Blocks.Sources.RealExpression ELsources(y=chp.Pel_set + Nsmr*bop.powerSensor.power
         + PVpower + WindPower)
    annotation (Placement(transformation(extent={{172,18},{258,64}})));
  Modelica.Blocks.Sources.RealExpression ELconsumption(y=april14 + HTSE_Pel + 1
        /0.63*3*14400*293*(30^(0.4/3/1.4) - 1)*HTSE_H2prod)
    annotation (Placement(transformation(extent={{172,-34},{260,14}})));
  Modelica.Blocks.Math.Add add1(k2=-1, y(unit="W"))
    annotation (Placement(transformation(extent={{300,2},{320,22}})));
  Modelica.Blocks.Math.Gain gain2(k=Nsmr)
    annotation (Placement(transformation(extent={{294,84},{314,104}})));
  Modelica.Blocks.Math.Gain gain3(k=Nsmr)
    annotation (Placement(transformation(extent={{294,-58},{314,-38}})));
  Modelica.Blocks.Sources.RealExpression ELconsumption1(y=ExtractedPower)
    annotation (Placement(transformation(extent={{242,-132},{276,-84}})));
  Modelica.Blocks.Sources.RealExpression ELconsumption2(y=HTSE_Pth)
    annotation (Placement(transformation(extent={{246,-192},{280,-144}})));
  Modelica.Blocks.Sources.RealExpression ELconsumption3(y=HTSE_Pel)
    annotation (Placement(transformation(extent={{246,-240},{280,-192}})));
  Modelica.Blocks.Math.Gain gain4(k=1/Nmod/Nsmr)
    annotation (Placement(transformation(extent={{-126,-208},{-106,-188}})));
  Modelica.Blocks.Math.Gain gain5(k=Nmod*Nsmr)
    annotation (Placement(transformation(extent={{162,-208},{182,-188}})));
  Modelica.Blocks.Interfaces.RealInput CCGT_Pel
    annotation (Placement(transformation(extent={{-360,152},{-320,192}})));
  Modelica.Blocks.Interfaces.RealOutput CCGTpower
    annotation (Placement(transformation(extent={{346,162},{366,182}})));
  Modelica.Blocks.Interfaces.RealInput H2target
    annotation (Placement(transformation(extent={{-360,72},{-320,112}})));
  Modelica.Blocks.Interfaces.RealInput H2load
    annotation (Placement(transformation(extent={{-358,-8},{-318,32}})));
  Modelica.Blocks.Interfaces.RealInput ElectricalLoad
    annotation (Placement(transformation(extent={{-358,-188},{-318,-148}})));
  Modelica.Blocks.Interfaces.RealInput PVpower
    annotation (Placement(transformation(extent={{-358,-268},{-318,-228}})));
  Modelica.Blocks.Interfaces.RealInput WindPower
    annotation (Placement(transformation(extent={{-360,-348},{-320,-308}})));
  Modelica.Blocks.Interfaces.RealOutput SOC
    annotation (Placement(transformation(extent={{342,-322},{362,-302}})));
  Modelica.Blocks.Interfaces.RealOutput GridPower
    annotation (Placement(transformation(extent={{346,2},{366,22}})));
  Modelica.Blocks.Interfaces.RealOutput Pth_SMR
    annotation (Placement(transformation(extent={{344,84},{364,104}})));
  Modelica.Blocks.Interfaces.RealOutput Pel_SMR
    annotation (Placement(transformation(extent={{346,-58},{366,-38}})));
  Modelica.Blocks.Interfaces.RealOutput Pth_HTSE
    annotation (Placement(transformation(extent={{344,-178},{364,-158}})));
  Modelica.Blocks.Interfaces.RealOutput Pel_HTSE
    annotation (Placement(transformation(extent={{344,-228},{364,-208}})));
  Modelica.Blocks.Interfaces.RealOutput H2prod
    annotation (Placement(transformation(extent={{344,-278},{364,-258}})));
  Modelica.Blocks.Interfaces.RealOutput Pth_COG
    annotation (Placement(transformation(extent={{346,-118},{366,-98}})));
  Modelica.Blocks.Sources.TimeTable april14(table=[0,170e6; 10,170e6; 13,140e6;
        15,140e6; 20,190e6; 24,190e6], timeScale(displayUnit="h") = 3600)
    annotation (Placement(transformation(extent={{-468,-144},{-448,-124}})));
  Modelica.Blocks.Sources.TimeTable april12(table=[0,170e6; 5,170e6; 7,190e6; 8,
        190e6; 12,140e6; 17,140e6; 19,190e6; 21,190e6; 23,170e6; 24,170e6],
      timeScale(displayUnit="h") = 3600)
    annotation (Placement(transformation(extent={{-468,-176},{-448,-156}})));
equation
  connect(sinkMassFlow1.flange,bop. flangeB1) annotation (Line(points={{-226,
          -73},{-147.433,-73},{-147.433,-32}},                color={0,0,255}));
  connect(sinkMassFlow2.flange,bop. flangeB3) annotation (Line(points={{-236,
          -83},{-131.8,-83},{-131.8,-32}},            color={0,0,255}));
  connect(sinkMassFlow3.flange,bop. flangeB4) annotation (Line(points={{-228,
          -95},{-116.167,-95},{-116.167,-32}},              color={0,0,255}));
  connect(bop.flangeA3,sourceMassFlow1. flange) annotation (Line(points={{
          -46.9333,-32},{-46.9333,-61},{-38,-61}},   color={0,0,255}));
  connect(bop.flangeA2,sourceMassFlow3. flange) annotation (Line(points={{
          -77.7533,-32},{-77.7533,-64},{-80,-64},{-80,-81},{-70,-81}},
                                                 color={0,0,255}));
  connect(bop.flangeA4,sourceMassFlow4. flange) annotation (Line(points={{
          -93.8333,-32},{-93.8333,-95},{-76,-95}},
                                                 color={0,0,255}));
  connect(bop.powerConnection,load. port) annotation (Line(
      points={{-38.4467,1},{-38.4467,-3.4},{-18,-3.4}},
      color={0,0,255},
      thickness=0.5));
  connect(frequencySensor.port,load. port) annotation (Line(
      points={{-18,14},{-18,-3.4}},
      color={0,0,255},
      thickness=0.5));
  connect(load.referencePower,realExpression. y) annotation (Line(points={{-14.7,
          -12},{-3.85,-12},{-3.85,-14},{7,-14}}, color={0,0,127}));
  connect(BOPctrl.actuatorBus,bop. actuatorBus) annotation (Line(
      points={{-110.889,56},{-120,56},{-120,34},{-131.8,34}},
      color={80,200,120},
      thickness=0.5));
  connect(BOPctrl.sensorBus,bop. sensorBus) annotation (Line(
      points={{-94.8889,56},{-94.8889,48},{-78.2,48},{-78.2,34}},
      color={255,219,88},
      thickness=0.5));
  connect(nsss.flangeA,bop. flangeB) annotation (Line(points={{-220,-11.16},{
          -196,-11.16},{-196,-10.7857},{-172,-10.7857}},  color={0,0,255}));
  connect(nsss.flangeB,bop. flangeA) annotation (Line(points={{-220,10.8},{-196,
          10.8},{-196,12.7857},{-172,12.7857}},
                                color={0,0,255}));
  connect(NSSSctrl.actuatorBus,nsss. actuatorBus) annotation (Line(
      points={{-260.4,34},{-260.4,28},{-263.5,28},{-263.5,17.64}},
      color={80,200,120},
      thickness=0.5));
  connect(NSSSctrl.sensorBus,nsss. sensorBus) annotation (Line(
      points={{-237.6,34},{-237.6,25.82},{-234.5,25.82},{-234.5,17.64}},
      color={255,219,88},
      thickness=0.5));
  connect(bop.flangeB2,pressDropLin. inlet) annotation (Line(points={{-163.067,
          -32},{-163.067,-151},{-92,-151}},            color={0,0,255}));
  connect(fixVol.terminal,hTSE_module. term_n) annotation (Line(points={{64,-237},
          {76,-237},{76,-224},{96,-224}},                     color={0,120,120}));
  connect(tSPro2TP.thermalPort,hTSE_module. extHeat)
    annotation (Line(points={{120,-180},{120,-192}},
                                                  color={0,0,0}));
  connect(pressDropLin.outlet,intermediateLoop_v2_1. flangeA) annotation (Line(
        points={{-82,-151},{-44,-151},{-44,-138.4},{-30,-138.4}},
                                                              color={0,0,255}));
  connect(intermediateLoop_v2_1.flangeA1,flow1DFV. outfl)
    annotation (Line(points={{68,-169.6},{68,-164},{92,-164}},
                                                            color={0,0,255}));
  connect(flow1DFV.infl,intermediateLoop_v2_1. flangeB1)
    annotation (Line(points={{92,-144},{68,-144},{68,-138.4}},
                                                            color={0,0,255}));
  connect(realExpression1.y,iLcontroller. h_steam) annotation (Line(points={{83,-84},
          {69.2,-84},{69.2,-87.6},{55.3,-87.6}},
                                              color={0,0,127}));
  connect(intermediateLoop_v2_1.actuatorBus_HTSE,iLcontroller. actuatorBus_HTSE)
    annotation (Line(
      points={{33.7,-128},{38.8,-128},{38.8,-118.38}},
      color={80,200,120},
      thickness=0.5));
  connect(iLcontroller.sensorBus_HTSE,intermediateLoop_v2_1. sensorBus_HTSE)
    annotation (Line(
      points={{-0.8,-118},{-0.8,-128},{-1.3,-128}},
      color={255,219,88},
      thickness=0.5));
  connect(flow1DFV.wall,tSPro2TP. dHTVolumes) annotation (Line(points={{97,-154},
          {108.4,-154},{108.4,-160},{119.8,-160}},
                                           color={255,127,0}));
  connect(intermediateLoop_v2_1.flangeB,bop. flangeA1) annotation (Line(points={{-29.3,
          -169.6},{-56,-169.6},{-56,-96},{-48,-96},{-48,-64},{-62.5667,-64},{
          -62.5667,-32}},color={0,0,255}));
  connect(cHP_controller.Pel_eff,chp. Pel_set) annotation (Line(points={{-60.92,
          181.2},{60,181.2},{60,188},{118,188},{118,157.68}},        color={0,
          0,127}));
  connect(cHP_controller.Pth_eff,chp. Pth_set) annotation (Line(points={{-60.56,
          160.8},{64,160.8},{64,176},{88,176},{88,157.68}},        color={0,0,
          127}));
  connect(const.y,cHP_controller. Pth_set) annotation (Line(points={{-131,142},
          {-112,142},{-112,160.8},{-99.08,160.8}},                       color={
          0,0,127}));
  connect(CCGT_Pel,cHP_controller. Pel_set) annotation (Line(points={{-340,172},
          {-112,172},{-112,181.2},{-99.44,181.2}},  color={0,0,127}));
  connect(gain1.y,CCGTpower)  annotation (Line(points={{295,172},{356,172}},
                                  color={0,0,127}));
  connect(gain1.u,chp. Pel_set) annotation (Line(points={{272,172},{118,172},{
          118,157.68}},                                          color={0,0,
          127}));
  connect(chp.powerConnection,grid. port) annotation (Line(
      points={{128,145.5},{128,154},{153.4,154}},
      color={0,0,255},
      thickness=0.5));
  connect(chp.ThermalPower,fixedTemperature. port) annotation (Line(points={{128,
          124.5},{128,126},{156,126}},
        color={191,0,0}));
  connect(H2load,add. u2) annotation (Line(points={{-338,12},{-292,12},{-292,
          -344},{168,-344}},                 color={0,0,127}));
  connect(add.y,integrator. u)
    annotation (Line(points={{191,-338},{216.4,-338}}, color={0,0,127}));
  connect(integrator.y,gain. u)
    annotation (Line(points={{257.8,-338},{280,-338}}, color={0,0,127}));
  connect(gain.y,SOC)  annotation (Line(points={{303,-338},{303,-340},{336,-340},
          {336,-312},{352,-312}},
        color={0,0,127}));
  connect(ELconsumption.y,add1. u2) annotation (Line(points={{264.4,-10},{292,
          -10},{292,6},{298,6}},            color={0,0,127}));
  connect(ELsources.y,add1. u1) annotation (Line(points={{262.3,41},{288,41},{
          288,18},{298,18}},    color={0,0,127}));
  connect(add1.y,GridPower)
    annotation (Line(points={{321,12},{356,12}},     color={0,0,127}));
  connect(realExpression3.y,gain2. u)
    annotation (Line(points={{253,95},{292,95},{292,94}},    color={0,0,127}));
  connect(gain2.y,Pth_SMR)
    annotation (Line(points={{315,94},{354,94}},   color={0,0,127}));
  connect(Pel_SMR,gain3. y)
    annotation (Line(points={{356,-48},{315,-48}},
                                                 color={0,0,127}));
  connect(gain3.u,realExpression. y) annotation (Line(points={{292,-48},{2,-48},
          {2,-32},{0,-32},{0,-14},{7,-14}},color={0,0,127}));
  connect(ELconsumption1.y,Pth_COG)  annotation (Line(points={{277.7,-108},{356,
          -108}},     color={0,0,127}));
  connect(ELconsumption2.y,Pth_HTSE)  annotation (Line(points={{281.7,-168},{
          354,-168}},      color={0,0,127}));
  connect(ELconsumption3.y,Pel_HTSE)  annotation (Line(points={{281.7,-216},{
          354,-216},{354,-218}},
                             color={0,0,127}));
  connect(H2target,gain4. u) annotation (Line(points={{-340,92},{-286,92},{-286,
          -198},{-128,-198}}, color={0,0,127}));
  connect(gain4.y,hTSE_module. H2_target)
    annotation (Line(points={{-105,-198},{96.8,-198}}, color={0,0,127}));
  connect(hTSE_module.H2_production,gain5. u)
    annotation (Line(points={{142.4,-198},{160,-198}}, color={0,0,127}));
  connect(gain5.y,H2prod)  annotation (Line(points={{183,-198},{208,-198},{208,
          -268},{354,-268}},
                       color={0,0,127}));
  connect(add.u1,H2prod)  annotation (Line(points={{168,-332},{166,-332},{166,
          -268},{354,-268}},
                       color={0,0,127}));
  annotation (uses(
      ThermoPower(version="3.2"),
      Modelica(version="4.0.0"),
      Buildings(version="11.0.0")));
end Trial2_project;
