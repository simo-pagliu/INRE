within ;
model Trial1_project
  TANDEM.SMR.BOP.BOP_TSPro.BOP_2Plug.StaticBoP3
                       StaticBOP2_PlugSGTSP_PlugCogSML(
    Pp_LP(
      C2(h(start=164184.75305878202), h_vol(start=164191.70520937204)),
      Qv(start=0.18396416597366846),
      h(start=163778.6102063112),
      Pm(start=363772.87837973965, displayUnit="bar")),
    Sing7(Pm(start=81483.88090490695, displayUnit="bar"), C2(h_vol(start=
              318004.84418054804))),
    P11(C1(h_vol(start=371631.93129043165))),
    Sing14(Pm(start=694616.4546996551, displayUnit="bar")),
    Vol14(h(start=487996.72664115264)),
    Sing4b(Pm(start=755863.7314451099, displayUnit="bar"), C2(h_vol(start=
              700826.4859500551))),
    Pp4(C2(h_vol(start=2639188.304057642), P(start=755863.731516966,
            displayUnit="bar"))),
    Vv12(Ouv(signal(start=0.7, fixed=false))),
    Vol10(h(start=164191.70520937204)),
    Vv10(Pm(start=717608.3792336329, displayUnit="bar")),
    Vol9(h(start=163365.51520324874)),
    Vol8(h(start=2147534.9782363693), Cs(h(start=2147534.97823637))),
    Vv7(Pm(start=80938.2970467849, displayUnit="bar"), C1(h_vol(start=
              2621755.7202959014))),
    Pip7(C2(P(start=81483.88117689801, displayUnit="bar"), h_vol(start=
              2621755.7202959014)), Q(start=16.0)),
    Vol7(
      Ce(h(start=2619840.1257646517)),
      Cs1(Q(start=-2.842170943040401E-14), h(start=2619840.125764651)),
      Cs2(h(start=2620466.1773813386)),
      h(start=2621755.7202959014)),
    Vol6(h(start=2977542.9234993923)),
    Vol5(h(start=2765272.378605388)),
    Vv4(Pm(start=740860.4782670301, displayUnit="bar"), C1(h_vol(start=
              2639188.304057642))),
    P4(C1(h_vol(start=2639188.304057642))),
    Vol4(Cs2(Q(start=24.570618097912405)), h(start=2639188.304057642)),
    Sing4(C2(h_vol(start=2492812.8893823405), P(start=741168.7528933026,
            displayUnit="bar"))),
    P2b(C1(h_vol(start=2751055.4478353322))),
    Pip2(C1(P(start=4468607.801056146, displayUnit="bar"), h_vol(start=
              2943650.4153317506))),
    Sing2(C1(h_vol(start=2943650.415331751)), Pm(start=4484416.962964356,
          displayUnit="bar")),
    Bach(
      h(start=487995.7996310873),
      Ce4(h(start=371631.2995773625)),
      Cs1(Q(start=244.2983525092077)),
      Ce3(Q(start=21.204195564406678))),
    Dry(Cev(h(start=2639676.0950998147)), Csv(h(start=2765284.8485874794))),
    SupH(
      DPfc(start=39891.1456653408, displayUnit="bar"),
      Ec(h(start=2943650.4153317516)),
      Ef(h(start=2765272.378605388)),
      Sf(h(start=2977121.8265122348), h_vol(start=2977542.923499393)),
      DPf(start=81735.80129097332, displayUnit="bar"),
      Sc(h_vol(start=1118785.4784898118))),
    Vol2(
      Cs1(h(start=2854461.5968234967)),
      h(start=2943650.4153317516),
      Ce(h(start=2943650.415331751))),
    Vol1(h(start=690937.8423668927)),
    ReH_BP(
      HDesF(start=371631.93129043165),
      HeiF(start=171009.89993465273),
      promeF(d(start=981.4445528787293, displayUnit="g/cm3")),
      Ee(h_vol(start=164205.69145221374), h(start=164191.70520937204)),
      Hep(start=393725.0712697711)),
    ReH_HP(
      HDesF(start=690936.0623263465),
      HeiF(start=493804.4575817768),
      Se(
        h_vol(start=679621.7421491045),
        h(start=690936.0623263465),
        P(start=4972964.078124865, displayUnit="bar")),
      promeF(d(start=928.4366408318273, displayUnit="g/cm3")),
      Hep(start=710778.0928075291)),
    Pp_HP(
      C2(h(start=492787.15518248087), h_vol(start=492787.15518248087)),
      Pm(start=2649394.384329739, displayUnit="bar"),
      Qv(start=0.2537658926107881),
      h(start=490391.9409118168)),
    Vv1(Ouv(signal(start=0.7, fixed=false)), Pm(start=4581980.951330721,
          displayUnit="bar")),
    Vv2(
      Q(start=219.1155858553195),
      C1(h_vol(start=2943650.4153317516), P(start=4451800.957266087,
            displayUnit="bar")),
      C2(h_vol(start=2943650.4153317516), P(start=4400001.189086886,
            displayUnit="bar"))),
    Q1(C1(h_vol(start=690937.8423668927))),
    T1(C1(h_vol(start=690937.8423668925))),
    P1(C1(h_vol(start=690937.8423668926))),
    T2(C1(h_vol(start=2943650.4153317506)), C2(h_vol(start=2943650.4153317516))),
    Turb_BP1(
      Cs(h(start=2621755.7202959023), h_vol(start=2619840.125764651)),
      xm(start=0.9902676112626673),
      Ps(start=81048.13419790535, displayUnit="bar"),
      Pe(start=661879.0065677789, displayUnit="bar")),
    CsBP1a(start=24789.121403189514),
    CsBP2(start=629.7547379428868),
    CsHP(start=651197.0971866344),
    HeatSink(proe(d(start=990.7572466324344, displayUnit="g/cm3")), Cv(Q(start=
              182.1681024769765))),
    SPurgeBP(start=188.23374753410693),
    SPurgeHP(start=35.86826283480325),
    ScondesBP(start=1117.4768845481353),
    ScondesHP(start=1340.6503847191232),
    Turb_BP2(
      Ps(start=7056.561129075783, displayUnit="bar"),
      pros(d(start=0.054609316755873674, displayUnit="g/cm3")),
      xm(start=0.9397529567878202),
      Ce(h_vol(start=2621755.7202959014)),
      Pe(start=81238.43223648514, displayUnit="bar")),
    SG_Secondary_In(h_vol(start=691076.9808245787)),
    SG_Secondary_Out(h_vol(start=2943650.4153317516), Q(start=
            239.72480633161524)),
    Turb_HP(Cs(h(start=2639188.304057642)), Ps(start=756001.1492580863,
          displayUnit="bar")),
    HeatNetwk_HP_Out(P(start=4451161.532520275, displayUnit="bar"), h(start=
            2943650.4153191415)),
    HeatNetwk_IP_Out(h_vol(start=2639595.2860046183)),
    HeatNetwk_LP_In(P(start=7056.178861423586, displayUnit="bar")),
    HeatNetwk_LP_Out(h(start=2621755.720373541)),
    HeatNetwk_HP_In(P(start=4624255.859260167, displayUnit="bar")),
    P_TurbHP_1stRow(signal(start=4412190.189143764)),
    Pp_LP_Out(h(start=486995.79950686404)))                         annotation (Placement(transformation(extent={{154,
            -182},{294,-112}})));
  Modelica.Fluid.Sources.MassFlowSource_h Heat_IP_Network_Out(
    redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
    use_m_flow_in=true,
    use_h_in=false,
    m_flow=100,
    h=135000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-4.5,-4.5},{4.5,4.5}},
        rotation=270,
        origin={234.5,-36.5})));
  Modelica.Blocks.Sources.Ramp HeatNwk_IP_In(
    height=115,
    duration=900,
    offset=0.01,
    startTime=100) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={236,-24})));
  Modelica.Fluid.Sources.Boundary_ph HeatNwk_IP_Out(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    p=1500000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=270,
        origin={253,-35})));
  Modelica.Fluid.Sources.MassFlowSource_h HeatNwk_LP_In(
    redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
    use_m_flow_in=true,
    use_h_in=false,
    m_flow=100,
    h=135000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-4.5,-4},{4.5,4}},
        rotation=180,
        origin={351.5,-138})));
  Modelica.Blocks.Sources.Ramp rampLP(
    height=250,
    duration=900,
    offset=0.01,
    startTime=100) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={370,-140})));
  Modelica.Fluid.Sources.Boundary_ph HeatNwk_LP_Out(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    p=1500000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=180,
        origin={353,-157})));
  Modelica.Blocks.Sources.Ramp HeatNwk_HP_In(
    height=15,
    duration=900,
    offset=0.01,
    startTime=100) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={158,-24})));
  Modelica.Fluid.Sources.MassFlowSource_h Heat_HP_Network_Out(
    redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
    use_m_flow_in=true,
    use_h_in=false,
    m_flow=100,
    h=135000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-4.5,-4.5},{4.5,4.5}},
        rotation=270,
        origin={154.5,-36.5})));
  Modelica.Fluid.Sources.Boundary_ph HeatNwk_HP_Out(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    p=1500000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=270,
        origin={179,-35})));
  TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.Fluid2TSPro          fluid2TSPro4 annotation (
      Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=270,
        origin={161,-49})));
  TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.TSPro2Fluid          fluid2TSPro5
                                                         annotation (
      Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={175,-51})));
  TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.Fluid2TSPro          fluid2TSPro1 annotation (
      Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=90,
        origin={233,-51})));
  TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.TSPro2Fluid          fluid2TSPro2
                                                         annotation (
      Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={249,-51})));
  TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.TSPro2Fluid          fluid2TSPro3
                                                         annotation (
      Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={337,-157})));
  TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.Fluid2TSPro          fluid2TSPro6 annotation (
      Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=0,
        origin={335,-141})));
  TANDEM.SMR.BOP.BOP_TSPro.FMU_Coupling.Adaptor4FMU.AdaptorRealModelicaTSP
    adaptorRealModelicaTSP annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={204,-44})));
  TANDEM.SMR.BOP.BOP_TSPro.FMU_Coupling.Adaptor4FMU.AdaptorRealModelicaTSP
    adaptorRealModelicaTSP1
                           annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={280,-44})));
  TANDEM.SMR.BOP.BOP_TSPro.FMU_Coupling.Adaptor4FMU.AdaptorRealModelicaTSP
    adaptorRealModelicaTSP2
                           annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={352,-172})));
  Modelica.Blocks.Sources.Ramp Set_Flow_TapSteam_HP(
    height=20,
    duration=900,
    offset=0.001,
    startTime=100) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={204,-24})));
  Modelica.Blocks.Sources.Ramp Set_Flow_TapSteam_IP(
    height=28,
    duration=900,
    offset=0.001,
    startTime=100) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={280,-24})));
  Modelica.Blocks.Sources.Ramp Set_Flow_TapSteam_LP(
    height=25,
    duration=900,
    offset=0.001,
    startTime=100) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={370,-172})));
  TANDEM.SMR.BOP.BOP_TSPro.FMU_Coupling.Adaptor4FMU.AdaptorRealModelicaTSP
    adaptorRealModelicaTSP3
                           annotation (Placement(transformation(
        extent={{-4,4},{4,-4}},
        rotation=180,
        origin={340,-84})));
  Modelica.Blocks.Sources.Ramp Set_P_TapSteam_IP(
    height=0,
    duration=900,
    offset=7.56e5,
    startTime=100) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={372,-86})));
  TANDEM.SMR.BOP.BOP_TSPro.FMU_Coupling.Adaptor4FMU.AdaptorRealModelicaTSP
    adaptorRealModelicaTSP4
                           annotation (Placement(transformation(
        extent={{-4,4},{4,-4}},
        rotation=180,
        origin={340,-102})));
  Modelica.Blocks.Sources.Ramp Set_P_TapSteam_LP(
    height=0,
    duration=900,
    offset=0.815e5,
    startTime=100) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={370,-100})));
  TANDEM.SMR.BOP.BOP_TSPro.BOP_2Plug.HX_cog
                   HX_cog_HP(
    Hx_Hybrid(
      DPc(start=2.479524994983914E-08, displayUnit="bar"),
      DPf(start=0.05963019607638345, displayUnit="bar"),
      Sc(h_vol(start=1118785.4784898118)),
      Ec(h(start=2943650.4153317516))),
    Vv_Tap(C2(h_vol(start=1118785.4784898118))),
    TCond_Tap(C2(h_vol(start=1118785.4784898118)))) annotation (Placement(transformation(extent={{158,-84},
            {172,-70}})));
  TANDEM.SMR.BOP.BOP_TSPro.BOP_2Plug.HX_cog
                      HX_cog_IP(
    Hx_Hybrid(
      DPc(start=1.195582336659725E-07, displayUnit="bar"),
      DPf(start=0.05966612058428442, displayUnit="bar"),
      Ec(h(start=2639188.304057642)),
      Sc(h_vol(start=710810.4235062235))),
    TCond_Tap(C2(h_vol(start=710810.4235062235))),
    Vv_Tap(C2(h_vol(start=710810.4235062235))),
    Vol_Tap(h(start=2639188.304057642)))
    annotation (Placement(transformation(extent={{220,-84},{234,-70}})));
  TANDEM.SMR.BOP.BOP_TSPro.BOP_2Plug.HX_cog_LP
                      HX_cog_LP(
    Hx_Hybrid_LP(
      DPc(start=1.006183525146145E-06, displayUnit="bar"),
      DPf(start=0.059773554781532685, displayUnit="bar"),
      Ec(h(start=2621755.7202959014)),
      Sc(h_vol(start=393747.5804603163))),
    TCond_Tap_LP(C2(h_vol(start=393747.5804603163))),
    Vv_Tap_LP(C2(h_vol(start=393747.5804603163))))
                                        annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=270,
        origin={315,-159})));
  TANDEM.SMR.BOP.BOP_TSPro.BOP_2Plug.CTRL_PI CTR_P_Tap_IP annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={312,-78})));
  TANDEM.SMR.BOP.BOP_TSPro.BOP_2Plug.CTRL_PI CTR_P_Tap_LP annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={312,-104})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe Set_MainDrum_P(
    Starttime=100,
    Duration=900,
    Initialvalue=7.147E5,
    Finalvalue=7.147E5) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={233,-197})));
  TANDEM.SMR.BOP.BOP_TSPro.BOP_2Plug.CTRL_PI CTR_P_Turb_HP
    annotation (Placement(transformation(extent={{192,-106},{206,-94}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Set_Pout_SG(k=300 +
        273) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={122,-174})));
  TANDEM.SMR.BOP.BOP_TSPro.BOP_2Plug.CTRL_PI
                    CTR_PT_PpHP annotation (Placement(transformation(
        extent={{6,-5},{-6,5}},
        rotation=90,
        origin={137,-174})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe Set_Ouv_Vv_SG_In(
    Starttime=100,
    Duration=900,
    Initialvalue=1,
    Finalvalue=1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={175,-199})));
  TANDEM.SMR.BOP.BOP_TSPro.BOP_2Plug.HX_HeatInput
                         HX_HeatInput(T_HeatInput(C2(h_vol(start=
              487995.7996310873))), Vv_HeatInput(C2(h_vol(start=
              487995.7996310873))))
    annotation (Placement(transformation(
        extent={{7,-7},{-7,7}},
        rotation=180,
        origin={265,-197})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Set_Liquid_Tapping_line_Flowrate(k=1e-3)
    annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={275,-221})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Set_P_In_TurbHP(k=44.5E5)
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={198,-80})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante ThermalPower_InputToRankine
    annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={255,-221})));
  TANDEM.SMR.NSSS.NSSS_ThermoPower.Control.NSSSctrl_ex2
                       NSSSctrl
    annotation (Placement(transformation(extent={{22,-110},{60,-78}})));
  TANDEM.SMR.NSSS.NSSS_ThermoPower.NSSSsimplified_fluid nsss(
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
        h(start={690937.8423668928,1064870.7514157868,1340564.8159344522,
              1583442.3069997572,1767402.42179104,1959645.4744647408,
              2192813.978529689,2416513.215588785,2617288.116428511,
              2817518.4492800417,2943650.415331751}),
        heatTransfer(gamma(start=14308.517324568174))), Primary(p(start=
              14767027.575329589, displayUnit="bar"), wall(T(start={
                589.9042652165566,588.0176336049378,585.7288398453098,
                583.4920193232052,584.0264664098835,580.3449429668044,
                578.0726833260838,576.0467781505952,574.0854410761073,
                565.9519664428825}, displayUnit="degC")))),
    LowerPlenum(p(start=15058335.330254601, displayUnit="bar")),
    core(fuel(
        Tc(start={599.3746604503278,601.9263151032364,604.4400160445794,
              606.9137767799631,609.3455224084037,611.7330866429734,
              614.0742035048177,616.3664897983715,618.607413552013,
              620.7942433521856}, displayUnit="degC"),
        Tci(start={607.0709641760956,609.6126427101676,612.1165362433052,
              614.5806650372223,617.0029612480846,619.3812659581304,
              621.7133209014313,623.9967510064081,626.2290329574838,
              628.4074447228353}, displayUnit="degC"),
        Tco(start={592.188996361697,594.7499652310686,597.272822871972,
              599.7555764821652,602.1961445717468,604.592353973558,
              606.9419315075601,609.2424863932183,611.4914785771831,
              613.6861678866301}, displayUnit="degC"),
        Tvol(start=[1106.578817096677,960.0016500293058,901.3910693375121,
              846.8076204597714,795.2455372673762; 1109.5085702143774,
              962.594134240766,903.8514625360174,849.146914731936,
              797.4722138923822; 1112.397829648536,965.150584505449,
              906.2775710010369,851.4535329875008,799.6677161485076;
              1115.244154221902,967.6688503583792,908.6673577900106,
              853.7255420780147,801.830207141639; 1118.0449952223844,
              970.1466866839086,911.018696364572,855.9609238831752,
              803.9577692917536; 1120.797692899955,972.5817506196134,
              913.3293676555867,858.1575725238752,806.0484016835574;
              1123.4994668379209,974.9715930399968,915.5970519842706,
              860.3132866846092,808.100012762022; 1126.147395663902,
              977.3136406117213,917.8193120372151,862.4257534319092,
              810.1104049349835; 1128.7383804693648,979.6051634442834,
              919.9935621757226,864.4925190441909,812.0772468165186;
              1131.269085978881,981.8432230723798,922.117019087871,
              866.5109421107381,813.9980286004151], displayUnit="degC")),
        neutronicKinetics(D(start={2.6297433004241203E+17,6.425892720202542E+17,
              1.7257554821707536E+17,1.6728770166583648E+17,13303534357977988.0,
              1894272960287383.5}), P(start=540e6, fixed=true))),
    flangeA(h_outflow(start=1064870.7514157868)),
    flangeB(h_outflow(start=2943650.415331751)),
    pressurizer(pressurizer(h(start=1862126.0574145121))),
    pump(h(start=1339553.169100718), q_single(start=0.8497619609894508)),
    htc2(start=14308.518, fixed=false))
    annotation (Placement(transformation(extent={{10,-172},{68,-136}})));
  TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.Fluid2TSPro
                                    fluid2TSPro7(steam_outlet(h(start=2944000.0)),
      port_a(h_outflow(start=2962802.891927479)))
    annotation (Placement(transformation(extent={{94,-154},{110,-138}})));
  TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.TSPro2Fluid
                                    fluid2TSPro8 annotation (Placement(
        transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={104,-162})));
  inner ThermoPower.System system(initOpt=ThermoPower.Choices.Init.Options.steadyState)
                                                                                          annotation (
    Placement(transformation(extent={{34,-52},{54,-32}})));
  TANDEM.H2production.HTSE.HTSE_module_steam hTSE_module(N_boiler=N_boiler) annotation (Placement(transformation(extent={{-16,-34},
            {24,6}})));
  Modelica.Blocks.Sources.Ramp H2_ramp(
    height=0.1,
    duration=500,
    startTime=500)
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
  Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(
    definiteReference=true,
    f=50,
    V=380000)
    annotation (Placement(transformation(extent={{-98,-52},{-70,-26}})));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe     rampe1(
    Starttime=500,
    Duration=500,
    Initialvalue=0.01,
    Finalvalue=20)
    annotation (Placement(transformation(extent={{-102,72},{-82,92}})));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ    sourcePQ(
    P0=754700,
    Q0=0.1,
    h0=2639.73e3)
    annotation (Placement(transformation(extent={{-68,60},{-48,80}})));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink    sink
    annotation (Placement(transformation(extent={{62,60},{82,80}})));
  ThermoSysPro.WaterSteam.HeatExchangers.DynamicOnePhaseFlowPipe
    dynamicOnePhaseFlowPipe(
    L=L_boiler,
    ntubes=NoP_boiler,
    Ns=N_boiler,
    inertia=false,
    dynamic_mass_balance=false,
    h(start={2639730.0,2389303.2708829213,2101323.9613705045,1473388.4286087365,
          1473388.4286087365}),
    P(start={754700,754700,754700,754700,754700}))
    annotation (Placement(transformation(extent={{-12,80},{8,60}})));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss wPloss1(K=1.e-2)
    annotation (Placement(transformation(extent={{-42,60},{-22,80}})));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss wPloss2(K=1.e-2,
      pro(d(start=10.529422752712195, displayUnit="g/cm3")))
    annotation (Placement(transformation(extent={{26,62},{46,82}})));
  TANDEM.SMR.BOP.BOP_TBL.BOP_TBL.Models.BOP_modelInterfaces
                                     BOPV_model annotation (
    Placement(visible = true, transformation(origin={346,93},           extent = {{-24, -23}, {24, 23}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_HP(
    duration=100,
    height=0,
    offset=-10e6,
    startTime=500)                                                                                  annotation (
    Placement(visible = true, transformation(origin={285,141},   extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_MP(
    duration=250,
    height=0,
    offset=-5e6,
    startTime=500)                                                                                 annotation (
    Placement(visible = true, transformation(origin={285,115},   extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp_LP(
    duration=100,
    height=0,
    offset=-1e6,
    startTime=500)                                                                                 annotation (
    Placement(visible = true, transformation(origin={283,91},   extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp superheating(
    duration=100,
    height=0,
    offset=35e6,
    startTime=500)                                                                                      annotation (
    Placement(visible = true, transformation(origin={285,61},     extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp evaporation(
    duration=100,
    height=0,
    offset=505e6,
    startTime=500)                                                                                      annotation (
    Placement(visible = true, transformation(origin={283,33},     extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Loads.Impedance imp(R(displayUnit="kOhm") =
      5)                                                                          annotation (
    Placement(visible = true, transformation(origin={426,78},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Electrical.AC.OnePhase.Sources.Generator gen(f=50) annotation (
    Placement(visible = true, transformation(origin={394,78},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(HeatNwk_IP_In.y,Heat_IP_Network_Out. m_flow_in)
    annotation (Line(points={{236,-28.4},{238.1,-28.4},{238.1,-32}},
        color={0,0,127}));
  connect(rampLP.y,HeatNwk_LP_In. m_flow_in) annotation (Line(points={{365.6,
          -140},{366,-141.2},{356,-141.2}},  color={0,0,127}));
  connect(HeatNwk_HP_In.y,Heat_HP_Network_Out. m_flow_in)
    annotation (Line(points={{158,-28.4},{158.1,-28},{158.1,-32}},
        color={0,0,127}));
  connect(Heat_HP_Network_Out.ports[1],fluid2TSPro4. port_a)
    annotation (Line(
      points={{154.5,-41},{154.5,-42.14},{161,-42.14}},
      color={0,127,255}));
  connect(HeatNwk_HP_Out.ports[1],fluid2TSPro5. port_b) annotation (
      Line(points={{179,-38},{180,-38},{180,-42},{175,-42},{175,-44}},
        color={0,127,255}));
  connect(Heat_IP_Network_Out.ports[1],fluid2TSPro1. port_a)
    annotation (Line(
      points={{234.5,-41},{233,-41},{233,-44.14}},
      color={0,127,255}));
  connect(HeatNwk_IP_Out.ports[1],fluid2TSPro2. port_b) annotation (
      Line(points={{253,-38},{254,-38},{254,-44},{249,-44}},
                                                     color={0,127,
          255}));
  connect(HeatNwk_LP_In.ports[1],fluid2TSPro6. port_a) annotation (
      Line(points={{347,-138},{341.86,-138},{341.86,-141}},
                                                      color={0,127,
          255}));
  connect(HeatNwk_LP_Out.ports[1],fluid2TSPro3. port_b) annotation (
      Line(points={{350,-157},{344,-157}},
                                         color={0,127,255}));
  connect(adaptorRealModelicaTSP2.u,Set_Flow_TapSteam_LP. y)
    annotation (Line(points={{356.8,-172},{365.6,-172}},
                                                       color={0,0,
          127}));
  connect(Set_Flow_TapSteam_HP.y,adaptorRealModelicaTSP. u)
    annotation (Line(points={{204,-28.4},{204,-39.2}},
                                                    color={0,0,127}));
  connect(Set_Flow_TapSteam_IP.y,adaptorRealModelicaTSP1. u)
    annotation (Line(points={{280,-28.4},{280,-39.2}},
                                                    color={0,0,127}));
  connect(adaptorRealModelicaTSP3.u,Set_P_TapSteam_IP. y)
    annotation (Line(points={{344.8,-84},{364,-84},{364,-86},{367.6,-86}},
        color={0,0,127}));
  connect(adaptorRealModelicaTSP4.u,Set_P_TapSteam_LP. y)
    annotation (Line(points={{344.8,-102},{362,-102},{362,-100},{365.6,-100}},
        color={0,0,127}));
  connect(fluid2TSPro4.steam_outlet,HX_cog_HP. Water_Cooling_In)
    annotation (Line(points={{160.998,-55.965},{160.8,-55.965},{160.8,-70.2}},
                                                                             color={0,0,255}));
  connect(HX_cog_HP.Steam_Tapping_In,StaticBOP2_PlugSGTSP_PlugCogSML. HeatNetwk_HP_Out)
    annotation (Line(points={{160.8,-83.8},{164,-83.8},{164,-102},{166.185,-102},
          {166.185,-112}},                                                                  color={0,0,255}));
  connect(HX_cog_HP.Condensate_Tapping_Out,StaticBOP2_PlugSGTSP_PlugCogSML. HeatNetwk_HP_In)
    annotation (Line(points={{164,-83.8},{166,-83.8},{166,-100},{170.593,-100},
          {170.593,-112}},                                                                color={255,0,0}));
  connect(HX_cog_HP.Water_Cooling_Out,fluid2TSPro5. steam_inlet)
    annotation (Line(points={{163.8,-70.2},{162,-70.2},{162,-62},{175,-62},{175,
          -58}},                                                                  color={255,0,0}));
  connect(HX_cog_HP.TapingSteamFlow,adaptorRealModelicaTSP. outputReal)
    annotation (Line(points={{167.8,-70.4},{167.8,-64},{204,-64},{204,-48.4}},
                                                                         color={0,0,255}));
  connect(CTR_P_Tap_IP.Set,adaptorRealModelicaTSP3. outputReal)
    annotation (Line(points={{321.6,-77},{332,-77},{332,-84},{335.6,-84}},
                                                                       color={0,0,255}));
  connect(CTR_P_Tap_LP.Set,adaptorRealModelicaTSP4. outputReal)
    annotation (Line(points={{321.6,-103},{330,-103},{330,-102},{335.6,-102}},
                                                                       color={0,0,255}));
  connect(CTR_P_Tap_IP.Sensor,StaticBOP2_PlugSGTSP_PlugCogSML. P_TurbIP_In)
    annotation (Line(points={{302.4,-73.25},{247.852,-73.25},{247.852,-112}},
                                                                          color={0,0,255}));
  connect(CTR_P_Tap_IP.Command,StaticBOP2_PlugSGTSP_PlugCogSML. Set_Vv_TurbIP_In_Opening)
    annotation (Line(points={{301.8,-84.25},{254.074,-84.25},{254.074,-112.519}},
                                                                               color={0,0,255}));
  connect(CTR_P_Tap_LP.Sensor,StaticBOP2_PlugSGTSP_PlugCogSML. P_TurbLP_In)
    annotation (Line(points={{302.4,-99.25},{267.296,-99.25},{267.296,-112.259}},
                                                                               color={0,0,255}));
  connect(CTR_P_Tap_LP.Command,StaticBOP2_PlugSGTSP_PlugCogSML. Set_Vv_TurbLP_In_Opening)
    annotation (Line(points={{301.8,-110.25},{298,-110.25},{298,-108},{272.741,
          -108},{272.741,-112.778}},                                                             color={0,0,255}));
  connect(StaticBOP2_PlugSGTSP_PlugCogSML.Set_P_PpBP_Out,Set_MainDrum_P. y)
    annotation (Line(points={{232.556,-181.741},{232.556,-184},{232,-184},{232,
          -190},{233,-190},{233,-191.5}},                                           color={0,0,255}));
  connect(CTR_P_Turb_HP.Command,StaticBOP2_PlugSGTSP_PlugCogSML. Set_Vv_TurbHP_In_Opening)
    annotation (Line(points={{203.375,-106.12},{203.259,-106.12},{203.259,-112}},
                                                                          color={0,0,255}));
  connect(CTR_P_Turb_HP.Sensor,StaticBOP2_PlugSGTSP_PlugCogSML. P_SG_Outb)
    annotation (Line(points={{195.675,-105.76},{196,-105.76},{196,-112},{
          198.333,-112}},                                                  color={0,0,255}));
  connect(CTR_PT_PpHP.Command,StaticBOP2_PlugSGTSP_PlugCogSML. Set_PpHP_RPM)
    annotation (Line(points={{142.1,-177.75},{150,-177.75},{150,-175},{154.519,
          -175}},                                                                   color={0,0,255}));
  connect(StaticBOP2_PlugSGTSP_PlugCogSML.T_SG_Out,CTR_PT_PpHP. Sensor)
    annotation (Line(points={{153.741,-170.593},{140,-170.593},{140,-171.15},{
          141.8,-171.15}},                                                                    color={0,0,255}));
  connect(Set_Pout_SG.y,CTR_PT_PpHP. Set) annotation (Line(points={{126.4,-174},
          {130,-174},{130,-173.4},{132.2,-173.4}},                                                                   color={0,0,255}));
  connect(StaticBOP2_PlugSGTSP_PlugCogSML.Set_Vv_SG_In_Opening,Set_Ouv_Vv_SG_In. y)
    annotation (Line(points={{174.481,-181.741},{175,-181.741},{175,-193.5}},color={0,0,255}));
  connect(StaticBOP2_PlugSGTSP_PlugCogSML.HeatNetwk_LP_Out,HX_cog_LP. fluidInletI)
    annotation (Line(points={{294,-154.519},{294,-154.8},{308.2,-154.8}},
                                                                        color={255,0,0}));
  connect(StaticBOP2_PlugSGTSP_PlugCogSML.HeatNetwk_LP_In,HX_cog_LP. fluidOutletI1)
    annotation (Line(points={{294,-158.407},{294,-158},{308.2,-158}},
                                                                    color={0,0,255}));
  connect(HX_cog_LP.fluidInletI1,fluid2TSPro6. steam_outlet)
    annotation (Line(points={{321.8,-154.8},{324,-154.8},{324,-141.002},{
          328.035,-141.002}},                                                              color={0,0,255}));
  connect(HX_cog_LP.fluidOutletI,fluid2TSPro3. steam_inlet) annotation (Line(points={{321.8,
          -157.8},{322,-157},{330,-157}},                                                                                color={255,0,0}));
  connect(HX_cog_LP.TapingSteamFlow_CogHP,adaptorRealModelicaTSP2. outputReal)
    annotation (Line(points={{321.6,-161.8},{326,-161.8},{326,-172},{347.6,-172}},
                                                                               color={0,0,255}));
  connect(fluid2TSPro1.steam_outlet,HX_cog_IP. Water_Cooling_In)
    annotation (Line(points={{233.002,-57.965},{233.002,-66},{222.8,-66},{222.8,
          -70.2}},                                                                 color={0,0,255}));
  connect(fluid2TSPro2.steam_inlet,HX_cog_IP. Water_Cooling_Out) annotation (Line(points={{249,-58},
          {249,-68},{225.8,-68},{225.8,-70.2}},                                                                                   color={0,0,255}));
  connect(HX_cog_IP.TapingSteamFlow,adaptorRealModelicaTSP1. outputReal)
    annotation (Line(points={{229.8,-70.4},{280,-70.4},{280,-48.4}},
                                                               color={0,0,255}));
  connect(HX_cog_IP.Steam_Tapping_In,StaticBOP2_PlugSGTSP_PlugCogSML. HeatNetwk_IP_Out)
    annotation (Line(points={{222.8,-83.8},{222.8,-108},{214.407,-108},{214.407,
          -111.741}},                                                               color={0,0,255}));
  connect(HX_cog_IP.Condensate_Tapping_Out,StaticBOP2_PlugSGTSP_PlugCogSML. HeatNetwk_IP_In)
    annotation (Line(points={{226,-83.8},{226,-111.741},{218.556,-111.741}},
                                                                        color={255,0,0}));
  connect(StaticBOP2_PlugSGTSP_PlugCogSML.Pp_LP_Out,HX_HeatInput. Liquid_Tapping_line)
    annotation (Line(points={{213.63,-182},{214,-182},{214,-188},{260.8,-188},{
          260.8,-190.2}},                                                              color={255,0,0}));
  connect(HX_HeatInput.Turb_IP_In,StaticBOP2_PlugSGTSP_PlugCogSML. Turb_IP_In)
    annotation (Line(points={{264,-190.2},{266,-190.2},{266,-188},{300,-188},{
          300,-122.63},{294,-122.63}},                                                              color={255,0,0}));
  connect(HX_HeatInput.FlowControl_LiquidTapingLine,
    Set_Liquid_Tapping_line_Flowrate.                                                 y)
    annotation (Line(points={{267.8,-203.6},{267.8,-210},{275,-210},{275,-215.5}},
                                                                           color={0,0,255}));
  connect(Set_P_In_TurbHP.y,CTR_P_Turb_HP. Set) annotation (Line(points={{198,
          -84.4},{198.3,-84},{198.3,-94.24}},                                                            color={0,0,255}));
  connect(HX_HeatInput.HeatInput2Rankine,ThermalPower_InputToRankine. y)
    annotation (Line(points={{262.4,-203.6},{262.4,-212},{255,-212},{255,-215.5}},
                                                                           color={0,0,255}));
  connect(NSSSctrl.actuatorBus,nsss. actuatorBus) annotation (Line(
      points={{29.6,-110},{29.6,-130},{24.5,-130},{24.5,-136.36}},
      color={80,200,120},
      thickness=0.5));
  connect(NSSSctrl.sensorBus,nsss. sensorBus) annotation (Line(
      points={{52.4,-110},{52.4,-130},{53.5,-130},{53.5,-136.36}},
      color={255,219,88},
      thickness=0.5));
  connect(nsss.flangeB,fluid2TSPro7. port_a) annotation (Line(points={{68,
          -143.2},{88,-143.2},{88,-146},{94.16,-146}},  color={0,0,255}));
  connect(nsss.flangeA,fluid2TSPro8. port_b) annotation (Line(points={{68,
          -165.16},{72,-165.16},{72,-166},{80,-166},{80,-162},{96,-162}},
        color={0,0,255}));
  connect(StaticBOP2_PlugSGTSP_PlugCogSML.SG_Secondary_Out,fluid2TSPro7. steam_outlet)
    annotation (Line(points={{153.741,-146.222},{108,-146.222},{108,-146.002},{
          109.96,-146.002}}, color={0,0,255}));
  connect(fluid2TSPro8.steam_inlet,StaticBOP2_PlugSGTSP_PlugCogSML. SG_Secondary_In)
    annotation (Line(points={{112,-162},{126,-162},{126,-153.741},{153.741,
          -153.741}}, color={0,0,255}));
  connect(hTSE_module.H2_target,H2_ramp. y) annotation (Line(points={{-19.2,0},
          {-44,0},{-44,10},{-49,10}},                    color={0,0,127}));
  connect(fixVol.terminal,hTSE_module. term_n) annotation (Line(points={{-70,-39},
          {-26,-39},{-26,-26},{-20,-26}},                     color={0,120,120}));
  connect(rampe1.y,sourcePQ. IMassFlow) annotation (Line(points={{-81,82},{-72,
          82},{-72,84},{-58,84},{-58,75}},
                                  color={0,0,255}));
  connect(sourcePQ.C,wPloss1. C1)
    annotation (Line(points={{-48,70},{-42,70}}, color={0,0,255}));
  connect(wPloss1.C2,dynamicOnePhaseFlowPipe. C1)
    annotation (Line(points={{-22,70},{-12,70}},color={0,0,255}));
  connect(dynamicOnePhaseFlowPipe.C2,wPloss2. C1) annotation (Line(points={{8,70},{
          22,70},{22,72},{26,72}},  color={0,0,255}));
  connect(wPloss2.C2,sink. C) annotation (Line(points={{46,72},{58,72},{58,70},
          {62,70}},color={0,0,255}));
  connect(dynamicOnePhaseFlowPipe.CTh,hTSE_module. extHeat)
    annotation (Line(points={{-2,67},{-2,10},{4,10},{4,6}},   color={0,0,0}));
  connect(superheating.y,BOPV_model. SG_superheating) annotation (
    Line(points={{292.7,61},{304,61},{304,82.42},{322.48,82.42}}, color = {0, 0, 127}));
  connect(evaporation.y,BOPV_model. SG_evaporator) annotation (
    Line(points={{290.7,33},{312,33},{312,75.06},{322.48,75.06}},   color = {0, 0, 127}));
  connect(ramp_LP.y,BOPV_model. int_LP) annotation (
    Line(points={{290.7,91},{322.48,91},{322.48,91.62}},
                                                  color = {0, 0, 127}));
  connect(ramp_MP.y,BOPV_model. int_MP) annotation (
    Line(points={{292.7,115},{306,115},{306,100.82},{322.48,100.82}},
                                                                color = {0, 0, 127}));
  connect(ramp_HP.y,BOPV_model. intHP) annotation (
    Line(points={{292.7,141},{312,141},{312,110.02},{322.48,110.02}},
                                                                color = {0, 0, 127}));
  connect(BOPV_model.
                Power,gen. P) annotation (
    Line(points={{370.48,77.36},{378,77.36},{378,78},{384,78}},
                                          color = {0, 0, 127}));
  connect(gen.
         terminal,imp. terminal) annotation (
    Line(points={{404,78},{416,78}}));
  annotation (uses(
      Modelica(version="4.0.0"),
      ThermoSysPro(version="4.0"),
      ThermoPower(version="3.2"),
      Buildings(version="11.0.0")));
end Trial1_project;
