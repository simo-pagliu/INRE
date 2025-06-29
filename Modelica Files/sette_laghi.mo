within ;
package sette_laghi

  model MethanationControlInput
    import      Modelica.Units.SI;
    import Modelica.Blocks.Interfaces.RealInput;
    import Modelica.Blocks.Interfaces.RealOutput;

    // Parameters
    parameter Real stoichRatio = 4 "H2:CO2 molar ratio (default = 4 for stoichiometric)";
    parameter SI.Time T = 0 "Response time for control ramp [s]";

    // Constants
    constant Real M_H2 = 2.0 "H2 molar mass [g/mol]";

    // Inputs
    RealInput m_H2_in "H2 mass flow rate [kg/s]"
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}}),
          iconTransformation(extent={{-120,-10},{-100,10}})));

    // Outputs
    RealOutput n_H2_out "H2 molar flow rate [mol/s]"
      annotation (Placement(transformation(extent={{100,40},{120,60}})));
    RealOutput n_CO2_out "CO2 molar flow rate [mol/s]"
      annotation (Placement(transformation(extent={{100,-60},{120,-40}})));

    // Internal variables (target values)
    Real n_H2_target;
    Real n_CO2_target;

    // State variables for first-order delay
    Real n_H2_delayed(start=0);
    Real n_CO2_delayed(start=0);

  equation
    // Convert to molar flow
    n_H2_target = m_H2_in * 1000 / M_H2;
    n_CO2_target = n_H2_target / stoichRatio;

    if T > 0 then
      der(n_H2_delayed) = (n_H2_target - n_H2_delayed) / T;
      der(n_CO2_delayed) = (n_CO2_target - n_CO2_delayed) / T;
    else
      n_H2_delayed = n_H2_target;
      n_CO2_delayed = n_CO2_target;
    end if;

    // Outputs
    n_H2_out = n_H2_delayed;
    n_CO2_out = n_CO2_delayed;

    annotation (Icon(graphics={
          Line(
            points={{-102,0},{-60,0}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{60,50},{100,50}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{60,-50},{100,-50}},
            color={28,108,200},
            thickness=1),
          Ellipse(
            extent={{60,60},{-60,-62}},
            lineColor={28,108,200},
            lineThickness=1,
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Line(
            points={{60,50},{46,38}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{60,-50},{46,-40}},
            color={28,108,200},
            thickness=1),
          Text(
            extent={{-58,64},{58,-60}},
            textColor={255,255,255},
            textString="Stechiometry")}));
  end MethanationControlInput;

  model MethanationReactor
    import      Modelica.Units.SI;
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
      annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
    RealOutput m_flow_rate "Total gas mass flow rate [kg/s] (CO2+CH4+H2)"
      annotation (Placement(transformation(extent={{100,40},{120,60}})));

    // Constants
    constant Real R = 8.314 "Gas constant [J/mol.K]";
    constant Real M_CH4 = 16.0 "CH4 molar mass [g/mol]";
    constant Real M_CO2 = 44.0 "CO2 molar mass [g/mol]";
    constant Real M_H2  = 2.0  "H2 molar mass [g/mol]";
    constant Real LHV_CH4 = 50.0e6 "CH4 PCI [J/kg]";
    constant Real LHV_H2  = 120.0e6 "H2 PCI [J/kg]";
    constant Real UHV_CH4 = 55.4e6 "CH4 PCS [J/kg]";
    constant Real UHV_H2 = 141.8e6 "H2 PCS [J/kg]";

    // Internal variables
    Real n_CH4_out, n_H2_out, n_CO2_out;
    Real m_CH4_out, m_H2_out, m_CO2_out;

    // Temporary variable
    Real CH4_formed;

    RealOutput PCS "Upper calorific value [MJ/kg]"
      annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
  algorithm
    // Conversion based on limiting reagent
    CH4_formed := min(n_CO2_in, n_H2_in / 4) * conversionEfficiency;

    // Molar flows after conversion
    n_CH4_out := CH4_formed;
    n_H2_out  := max(n_H2_in - 4 * CH4_formed, 0);
    n_CO2_out := max(n_CO2_in - 1 * CH4_formed, 0);

    // Mass flows [kg/s]
    m_CH4_out := n_CH4_out * M_CH4 / 1000;
    m_H2_out  := n_H2_out  * M_H2  / 1000;
    m_CO2_out := n_CO2_out * M_CO2 / 1000;

    m_flow_rate := max(m_CH4_out + m_H2_out + m_CO2_out, 1e-6); // stabilized

    // Calorific value [MJ/kg]
    PCI := max((m_CH4_out*LHV_CH4 + m_H2_out*LHV_H2) / m_flow_rate, 0);
    PCS := max((m_CH4_out*UHV_CH4 + m_H2_out*UHV_H2) / m_flow_rate, 0);

  end MethanationReactor;

  model Testing
    parameter Real N_HTSE = 8 "Number of HTSE Modules in the H2 Plant";
    parameter Integer N_boiler=3 "Number of thermal nodes in the boiler";
    MethanationReactor             methanationReactor(conversionEfficiency=0.8)
      annotation (Placement(transformation(extent={{28,-268},{106,-190}})));
    MethanationControlInput             methanationControlInput(stoichRatio=8, T=0)
             annotation (Placement(transformation(extent={{-118,-266},{-40,-188}})));
    H2_Buffer bufferH2(Content(start=10)) annotation (Placement(Placement(
            transformation(extent={{0,20},{0,15}})), transformation(extent={{-230,
              -204},{-172,-262}})));
    CH4_Buffer bufferCH4(Content(start=10)) annotation (Placement(Placement(
            transformation(extent={{0,20},{0,15}})), transformation(extent={{326,-178},
              {384,-236}})));
    TurboGas                      gasTurbine annotation (Placement(
          transformation(extent={{152,-282},{192,-242}},
                                                   rotation=0)));
    ThermoPower.Gas.SinkPressure
                          sinkP(redeclare package Medium =
          ThermoPower.Media.FlueGas) annotation (Placement(transformation(
            extent={{246,-248},{266,-228}},
                                      rotation=0)));
    ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas(
        redeclare package Medium = ThermoPower.Media.FlueGas) annotation (
        Placement(transformation(extent={{204,-264},{224,-244}},
                                                           rotation=0)));
    Modelica.Blocks.Sources.RealExpression NPPpowerElectric(y=bop.powerSensor.power)
      annotation (Placement(transformation(
          extent={{-72,-17},{72,17}},
          rotation=180,
          origin={438,173})));
    Modelica.Blocks.Sources.TimeTable CH4demand(table=[0.0,0; 100,0.1; 200,0.2; 300,
          0.3; 400,0.4; 500,0.5; 600,0.6; 700,0.7; 800,0.7])
      annotation (Placement(transformation(extent={{50,-168},{98,-120}})));
    Control_Room control_Room(n_HTSE=N_HTSE, P_nom_turb=235e6)
      annotation (Placement(transformation(extent={{88,-40},{-40,82}})));
    Modelica.Blocks.Sources.TimeTable ELECTRICdemand(table=[0.0,0; 100,20e6; 800,50e6;
          1000,50e6])
      annotation (Placement(transformation(extent={{484,-36},{436,12}})));
    Modelica.Blocks.Sources.RealExpression Pelec_HTSE(y=h2plant.hTSE_module.ElectricityPower.y)
      annotation (Placement(transformation(extent={{526,-118},{416,-80}})));
    Modelica.Blocks.Sources.RealExpression Pelec_TURBOGAS(y=gasTurbine.P_el)
      annotation (Placement(transformation(extent={{526,32},{416,70}})));
    Modelica.Blocks.Sources.Ramp ramp2(
      height=1,
      duration=500,
      offset=0,
      startTime=0)
      annotation (Placement(transformation(extent={{48,-312},{68,-292}})));
    Modelica.Blocks.Sources.RealExpression heat2HTSE1(y=HX_cog_IP.Hx_Hybrid.W/
          N_boiler)
      annotation (Placement(transformation(extent={{55,-19},{-55,19}},
          rotation=90,
          origin={-371,17})));
    H2plant h2plant(N_HTSE=N_HTSE, N_boiler=N_boiler)
      annotation (Placement(transformation(extent={{-410,-244},{-312,-138}})));
    inner ThermoPower.System system(initOpt=ThermoPower.Choices.Init.Options.steadyState)
      annotation (Placement(transformation(extent={{50,304},{70,324}})));
    ThermoPower.Electrical.Load load(Pnom=170e6, usePowerInput=true)
      annotation (Placement(transformation(extent={{50,254},{30,274}})));
    Modelica.Fluid.Sources.MassFlowSource_h Heat_IP_Network_Out(
      redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
      use_m_flow_in=true,
      use_h_in=false,
      m_flow=100,
      h=135000,
      nPorts=1) annotation (Placement(transformation(
          extent={{-4.5,-4.5},{4.5,4.5}},
          rotation=270,
          origin={-263.5,235.5})));
    Modelica.Blocks.Sources.Ramp HeatNwk_IP_In(
      height=120,
      duration=900,
      offset=0.01,
      startTime=100) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=270,
          origin={-262,248})));
    Modelica.Fluid.Sources.Boundary_ph HeatNwk_IP_Out(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=false,
      p=1500000,
      nPorts=1) annotation (Placement(transformation(
          extent={{-3,-3},{3,3}},
          rotation=270,
          origin={-245,237})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.Fluid2TSPro fluid2TSPro1
      annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=90,
          origin={-265,221})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.TSPro2Fluid fluid2TSPro2
      annotation (Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=90,
          origin={-249,221})));
    TANDEM.SMR.BOP.BOP_TSPro.FMU_Coupling.Adaptor4FMU.AdaptorRealModelicaTSP adaptorRealModelicaTSP1
      annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=270,
          origin={-218,228})));
    TANDEM.SMR.BOP.BOP_TSPro.BOP_2Plug.HX_cog HX_cog_IP(
      Hx_Hybrid(
        DPc(start=1.1937366759301423E-07, displayUnit="bar"),
        DPf(start=0.059666027103045215, displayUnit="bar"),
        Ec(h(start=2639609.877779146)),
        Sc(h_vol(start=711083.3242149337)),
        DPfc(start=1.1940782842197216E-07, displayUnit="bar"),
        DPff(start=0.0596661726252597, displayUnit="bar")),
      TCond_Tap(C2(h_vol(start=711083.3242149337))),
      Vv_Tap(C2(h_vol(start=711083.3242149337))),
      Condensate_Tapping_Out(h_vol(start=711083.3242149337)),
      Steam_Tapping_In(h(start=2639609.877779149)),
      Vol_Tap(h(start=2639609.877779146)))
      annotation (Placement(transformation(extent={{-256,190},{-242,204}})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.Fluid2TSPro fluid2TSPro3(
        steam_outlet(h(start=2944000.0)), port_a(h_outflow(start=2962802.891927479)))
                                   annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=180,
          origin={-166,172})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.TSPro2Fluid fluid2TSPro4
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=0,
          origin={-164,198})));
    Modelica.Blocks.Sources.Ramp HeatNwk_HP_In(
      height=120,
      duration=900,
      offset=0.01,
      startTime=100) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=270,
          origin={-256,380})));
    Modelica.Fluid.Sources.MassFlowSource_h Heat_HP_Network_Out(
      redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
      use_m_flow_in=true,
      use_h_in=false,
      m_flow=100,
      h=135000,
      nPorts=1) annotation (Placement(transformation(
          extent={{-4.5,-4.5},{4.5,4.5}},
          rotation=270,
          origin={-259.5,367.5})));
    Modelica.Fluid.Sources.Boundary_ph HeatNwk_HP_Out(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=false,
      p=1500000,
      nPorts=1) annotation (Placement(transformation(
          extent={{-3,-3},{3,3}},
          rotation=270,
          origin={-235,369})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.Fluid2TSPro          fluid2TSPro5 annotation (
        Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=270,
          origin={-253,355})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.TSPro2Fluid          fluid2TSPro6
                                                           annotation (
        Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=90,
          origin={-239,353})));
    TANDEM.SMR.BOP.BOP_TSPro.FMU_Coupling.Adaptor4FMU.AdaptorRealModelicaTSP
      adaptorRealModelicaTSP annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=270,
          origin={-210,360})));
    Modelica.Blocks.Sources.Ramp Set_Flow_TapSteam_HP(
      height=0,
      duration=900,
      offset=0.001,
      startTime=100) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=270,
          origin={-210,380})));
    TANDEM.SMR.BOP.BOP_TSPro.BOP_2Plug.HX_cog
                     HX_cog_HP(
      Hx_Hybrid(
        DPc(start=2.4435370387197308E-08, displayUnit="bar"),
        DPf(start=0.05962862289370117, displayUnit="bar"),
        Sc(h_vol(start=1122142.992781656)),
        Ec(h(start=2944106.3643035744)),
        DPfc(start=2.452980926549997E-08, displayUnit="bar"),
        DPff(start=0.05962919799262121, displayUnit="bar")),
      Vv_Tap(C2(h_vol(start=1122142.992781656))),
      TCond_Tap(C2(h_vol(start=1122142.992781656))),
      Steam_Tapping_In(h(start=2944106.3643035744)),
      Vol_Tap(h(start=2944106.3643035744)))           annotation (Placement(transformation(extent={{-238,
              322},{-224,336}})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.TSPro2Fluid fluid2TSPro7
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=0,
          origin={-158,240})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.Fluid2TSPro fluid2TSPro8(
        steam_outlet(h(start=2944000.0)), port_a(h_outflow(start=2962802.891927479)))
                                   annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=180,
          origin={-158,228})));
    Modelica.Fluid.Sources.MassFlowSource_h HeatNwk_LP_In(
      redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
      use_m_flow_in=true,
      use_h_in=false,
      m_flow=100,
      h=135000,
      nPorts=1) annotation (Placement(transformation(
          extent={{-4.5,-4},{4.5,4}},
          rotation=180,
          origin={77.5,232})));
    Modelica.Blocks.Sources.Ramp rampLP(
      height=120,
      duration=900,
      offset=0.01,
      startTime=100) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=180,
          origin={96,230})));
    Modelica.Fluid.Sources.Boundary_ph HeatNwk_LP_Out(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=false,
      p=1500000,
      nPorts=1) annotation (Placement(transformation(
          extent={{-3,-3},{3,3}},
          rotation=180,
          origin={79,213})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.TSPro2Fluid          fluid2TSPro9
                                                           annotation (
        Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=0,
          origin={63,213})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.Fluid2TSPro          fluid2TSPro10
                                                                                     annotation (
        Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=0,
          origin={61,229})));
    TANDEM.SMR.BOP.BOP_TSPro.FMU_Coupling.Adaptor4FMU.AdaptorRealModelicaTSP
      adaptorRealModelicaTSP2
                             annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=180,
          origin={78,198})));
    Modelica.Blocks.Sources.Ramp Set_Flow_TapSteam_LP(
      height=0,
      duration=900,
      offset=0.001,
      startTime=100) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=180,
          origin={96,198})));
    TANDEM.SMR.BOP.BOP_TSPro.BOP_2Plug.HX_cog_LP
                        HX_cog_LP(
      Hx_Hybrid_LP(
        DPc(start=1.0213770701459113E-06, displayUnit="bar"),
        DPf(start=0.05977430533560828, displayUnit="bar"),
        Ec(h(start=2621766.47834097)),
        Sc(h_vol(start=391984.5158094587)),
        DPfc(start=1.021218703891956E-06, displayUnit="bar"),
        DPff(start=0.05977420587861938, displayUnit="bar")),
      TCond_Tap_LP(C2(h_vol(start=391984.5158094587))),
      Vv_Tap_LP(C2(h_vol(start=391984.5158094587))),
      Vol7(h(start=2621766.47834097)),
      fluidInletI(h(start=2621766.4783409717)),
      fluidOutletI1(h_vol(start=391984.5158094587)))
                                          annotation (Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=270,
          origin={41,211})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.TSPro2Fluid fluid2TSPro11
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=180,
          origin={14,208})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.Fluid2TSPro fluid2TSPro12(
        steam_outlet(h(start=2944000.0)), port_a(h_outflow(start=2962802.891927479)))
                                   annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=0,
          origin={14,214})));
    TANDEM.SMR.BOP.BOP_TSPro.BOP_2Plug.HX_HeatInput
                           HX_HeatInput(
      T_HeatInput(C2(h_vol(start=466374.3984095717))),
      Vv_HeatInput(C2(h_vol(start=466374.3984095717))),
      Liquid_Tapping_line(h(start=465374.3984095717)),
      Vol_Tap(h(start=466374.3984095717)))
      annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=180,
          origin={-39,159})));
    ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Set_Liquid_Tapping_line_Flowrate(k=1e-3)
      annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=90,
          origin={-29,135})));
    ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante ThermalPower_InputToRankine
      annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=90,
          origin={-49,135})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.TSPro2Fluid fluid2TSPro13
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=90,
          origin={-36,184})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.Fluid2TSPro fluid2TSPro14(
        steam_outlet(h(start=2944000.0)), port_a(h_outflow(start=2962802.891927479)))
                                   annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=270,
          origin={-46,184})));
    TANDEM.SMR.NSSS.NSSS_ThermoPower.Control.NSSSctrl_ex2
                         NSSSctrl
      annotation (Placement(transformation(extent={{-152,314},{-114,346}})));
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
          heatTransfer(gamma(start=14586.649512440295)),
          h(start={687347.8935488948,1064946.1647611712,1341716.155222091,1585307.4080712595,
                1769403.3275958602,1961873.102383314,2195618.6257879734,2419768.3172225566,
                2620868.6353172557,2820118.24037197,2944106.3643035744})),
          Primary(p(start=14766715.218693856, displayUnit="bar"), wall(T(start={589.4082287819939,
                  587.5173057493705,585.2231053970795,582.9825962654701,583.5859133445866,
                  579.8971845995204,577.5967200282101,575.5710566193154,573.6111123867778,
                  565.3798590723168}, displayUnit="degC")))),
      htc2(fixed=false, start=14586.649512440295),
      core(neutronicKinetics(P(start=540e6, fixed=true)), fuel(
          Tc(start={598.8485267209098,601.4035526585864,603.9211273787487,606.3992916001216,
                608.8359984035769,611.2291109638,613.576395652504,615.8755068844395,
                618.1239590989708,620.3190808301662}, displayUnit="degC"),
          Tci(start={606.5468900444794,609.0919223973908,611.599670414378,614.0681814774575,
                616.495415629274,618.879243312943,621.2174385015434,623.5076636023115,
                625.7474415456983,627.934110031119}, displayUnit="degC"),
          Tco(start={591.6609396860848,594.2252961473115,596.7520455818084,599.2392224871089,
                601.6847734442164,604.0865548416372,606.4423259540589,608.7497337340378,
                611.0062846932235,613.2092988084463}, displayUnit="degC"),
          Tvol(start=[1105.9751157884032,959.4674202468113,900.8840483513684,846.325544710997,
                794.7866604051272; 1108.908088571398,962.0627959886949,903.3472039996595,
                848.6674820220086,797.0158678417474; 1111.8011667195126,964.622666603949,
                905.7765762909835,850.9772195729826,799.2143538408656; 1114.6519422463166,
                967.1449108512938,908.1701559527464,853.2528504644085,801.3803064399116;
                1117.457900571859,969.6273136675054,910.5258449007742,855.4923835683683,
                803.5118336960317; 1120.2164178332905,972.0675637916177,912.8414539880546,
                857.6937413917203,805.6069616556396; 1122.924752880846,974.4632466859515,
                915.1146962897845,859.854753695151,807.663628284036; 1125.5800297344547,
                976.8118290194394,917.3431723821283,861.9731435013649,809.6796701518058;
                1128.1792051179127,979.1106299560945,919.5243431026096,864.0465012048671,
                811.6527977990784; 1130.7190151479756,981.356774016376,921.6554848302269,
                866.0722420690554,813.58055529342], displayUnit="degC"))),
      flangeB(h_outflow(start=2944106.3643035744)),
      pump(q_single(start=0.8498079349769984), h(start=1336699.0456428102)),
      flangeA(h_outflow(start=1064946.1647611712)),
      pressurizer(pressurizer(h(start=1862126.0574145121))))
      annotation (Placement(transformation(extent={{-162,256},{-104,292}})));
    TANDEM.SMR.BOP.BOP_POLIMI.Control.BOPcontroller_Cogeneration
                                       BOPctrl(
      PID1(limiter(u(start=-0.234844074605851)), gainPID(y(start=0.042442084759688664))),
      PID10(limiter(u(start=0.00021717055644652109)), gainPID(y(start=0.0002171705564670664))),
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
      annotation (Placement(transformation(extent={{-58,312},{-28,338}})));

    TANDEM.SMR.BOP.BOP_POLIMI.BOPdyn_fluid
                 bop(
      LP_TAV(allowFlowReversal=false, dp(start=49976.15459620149, displayUnit="bar")),
      CNDpump(dp(start=784312.2193723671, displayUnit="bar"), h(start=164353.2596440803)),
      FWpump(
        dp(start=4019700.053627746, displayUnit="bar"),
        h(start=470048.16904780775),
        inletFluidState(h(start=464762.74452770816), p(start=674700.0,
              displayUnit="bar")),
        q_single(start=0.25238031865554933)),
      FWtank(hout(start=464762.74452770816), inlet(m_flow(start={182.55809058420135,
                20.779072368963686,11.665027087211513,25.003329372318213,0.0010000000474974513}))),
      HP_TAV(
        dp(start=83468.38568951283, displayUnit="bar"),
        w(start=216.87287270012862),
        fluidState(h(start=2944106.364303575)),
        outlet(p(start=4416531.614310487, displayUnit="bar"))),
      LPTurbine1(
        steamState_in(p(start=636783.2762532821, displayUnit="bar")),
        eta_iso_nom=0.9,
        corrWet=true,
        corrFlow=true,
        eta_iso(start=0.8913592492841899)),
      LPTurbine2(
        w(start=166.06766731246455),
        eta_iso_nom=0.9,
        corrWet=true,
        corrFlow=true,
        steamState_in(p(start=79250.60705941985, displayUnit="bar")),
        eta_iso(start=0.845811081811772)),
      hp_fw(shell_2ph(h(start={2639610.136857381,2574398.6911774203,2492056.5434580203,
                2388110.8926207623,2256942.7322803335,2091511.738165602,1883032.6478808254,
                1620613.2455945762,1290889.9721959964,877754.7983572524,553815.7396726587}),
            p(start=757148.917031315, displayUnit="bar")), flangeB1(h_outflow(
              start=687342.7188409794))),
      lp_fw(shell_2ph(h(start={2621766.536753741,2556772.5434357887,2474014.9230734445,
                2368757.1377552887,2235082.33993792,2065660.872271856,1851523.66657229,
                1581898.6840277603,1244230.2827270308,824623.739009895,333062.74404833495}),
            p(start=80244.03752206039, displayUnit="bar")), flangeB(m_flow(start=-16.50412201408733))),
      mixer(h(start=2763166.530261766)),
      moistureSeparator(steam(h_outflow(start=2763179.113822877), p(start=707810.5498582933,
              displayUnit="bar")), inlet(p(start=707172.7624351135, displayUnit="bar"))),
      pressDropLin3(state(d(start=902.1555302385668, displayUnit="g/cm3"))),
      rh(shell_2ph(h(start={2944106.364303575,2890364.758696105,2854460.031102937,
                2829994.8508293987,2813089.0952963904,2769066.8963323813,2684241.1813017344,
                2534788.3606152576,2272728.532176967,1816479.0360469588,1049549.8820976075}))),
      valve_SGin(dp(start=100351.7920709017, displayUnit="bar"), fluidState(p(
              start=4656083.644885505, displayUnit="bar"))),
      HPTurbine(
        eta_iso_nom=0.9,
        corrWet=true,
        corrFlow=true,
        eta_iso(start=0.8722649294586934)),
      sensT1_2(T(start=300 + 273.15)),
      LP_TAV1(dp(start=993.4304626405356, displayUnit="bar")),
      flangeA1(h_outflow(start=710502.0457445189)),
      mixer2(h(start=687344.5310518404)),
      valveLiq(dp(start=42448.91703131504, displayUnit="bar")),
      flowSplit2(out2(m_flow(start=-16.503145774935035))),
      mixer1(h(start=2147066.3953712382)),
      valveLiq1(dp(start=73244.03752206039, displayUnit="bar")))
      annotation (Placement(transformation(extent={{-88,250},{6,296}})));

    Modelica.Blocks.Sources.Ramp Set_Flow_TapSteam_IP(
      height=28,
      duration=900,
      offset=0.001,
      startTime=100) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=270,
          origin={-318,244})));
  equation
    connect(methanationControlInput.n_H2_out,methanationReactor. n_H2_in)
      annotation (Line(points={{-36.1,-207.5},{16,-207.5},{16,-209.5},{24.1,-209.5}},
                                                          color={0,0,127}));
    connect(methanationControlInput.n_CO2_out,methanationReactor. n_CO2_in)
      annotation (Line(points={{-36.1,-246.5},{16,-246.5},{16,-248.5},{24.1,-248.5}},
                                                          color={0,0,127}));
    connect(bufferH2.mass_flow_out,methanationControlInput. m_H2_in)
      annotation (Line(points={{-167.65,-230.97},{-132,-230.97},{-132,-227},{-121.9,
            -227}},
          color={0,0,127}));
    connect(methanationReactor.m_flow_rate,bufferCH4. mass_flow_in) annotation (
       Line(points={{109.9,-209.5},{304,-209.5},{304,-207},{320.2,-207}},
                                                                color={0,0,127}));
    connect(stateReader_gas.inlet,gasTurbine. flueGasOut) annotation (Line(
        points={{208,-254},{192,-254},{192,-246}},
        color={159,159,223},
        thickness=0.5));
    connect(stateReader_gas.outlet,sinkP. flange) annotation (Line(
        points={{220,-254},{236,-254},{236,-238},{246,-238}},
        color={159,159,223},
        thickness=0.5));
    connect(gasTurbine.fuelFlowRateOut,bufferCH4. mass_flow_out) annotation (
        Line(points={{194,-264},{196,-264},{196,-294},{355.29,-294},{355.29,-241.51}},
                      color={0,0,127}));
    connect(bufferCH4.mass_flow_to_grid,CH4demand. y) annotation (Line(points={{355,
            -172.2},{355,-144},{100.4,-144}},                     color={0,0,
            127}));
    connect(NPPpowerElectric.y,control_Room. P_nuc) annotation (Line(points={{358.8,
            173},{100.8,173},{100.8,69.8}},color={0,0,127}));
    connect(control_Room.P_HTSE,Pelec_HTSE. y) annotation (Line(points={{100.8,-27.8},
            {100.8,-99},{410.5,-99}},         color={0,0,127}));
    connect(control_Room.P_turbine,Pelec_TURBOGAS. y) annotation (Line(points={{100.8,
            45.4},{396,45.4},{396,51},{410.5,51}},     color={0,0,127}));
    connect(control_Room.Demand,ELECTRICdemand. y) annotation (Line(points={{100.8,
            -3.4},{424,-3.4},{424,-12},{433.6,-12}},   color={0,0,127}));
    connect(methanationReactor.PCS,gasTurbine. HHV) annotation (Line(points={{109.9,
            -256.3},{136,-256.3},{136,-254},{150,-254}},
                                                      color={0,0,127}));
    connect(methanationReactor.PCI,gasTurbine. LHV) annotation (Line(points={{109.9,
            -244.6},{144,-244.6},{144,-248},{150,-248}},
                                                  color={0,0,127}));
    connect(ramp2.y,gasTurbine. GTLoad) annotation (Line(points={{69,-302},{96,-302},
            {96,-274},{152,-274},{152,-262}},     color={0,0,127}));
    connect(h2plant.H2_plant_output,bufferH2. demand) annotation (Line(points={{-302.2,
            -191},{-236.38,-191},{-236.38,-220.24}},
                                                  color={0,0,127}));
    connect(h2plant.H2_plant_output,bufferH2. mass_flow_in) annotation (Line(
          points={{-302.2,-191},{-302.2,-247.5},{-235.8,-247.5}},
                                                               color={0,0,127}));
    connect(heat2HTSE1.y,h2plant. H2_plant_Heat_Input) annotation (Line(points={{-371,
            -43.5},{-371,-110},{-361,-110},{-361,-127.4}},
                                             color={0,0,127}));
    connect(HeatNwk_IP_In.y,Heat_IP_Network_Out. m_flow_in)
      annotation (Line(points={{-262,243.6},{-259.9,243.6},{-259.9,240}},
          color={0,0,127}));
    connect(Heat_IP_Network_Out.ports[1],fluid2TSPro1. port_a)
      annotation (Line(
        points={{-263.5,231},{-265,231},{-265,227.86}},
        color={0,127,255}));
    connect(HeatNwk_IP_Out.ports[1],fluid2TSPro2. port_b) annotation (
        Line(points={{-245,234},{-244,234},{-244,228},{-249,228}},
                                                       color={0,127,
            255}));
    connect(fluid2TSPro1.steam_outlet,HX_cog_IP. Water_Cooling_In)
      annotation (Line(points={{-264.998,214.035},{-264.998,203.8},{-253.2,
            203.8}},                                                                 color={0,0,255}));
    connect(fluid2TSPro2.steam_inlet,HX_cog_IP. Water_Cooling_Out) annotation (Line(points={{-249,
            214},{-248,214},{-248,210},{-250.2,210},{-250.2,203.8}},                                                                color={0,0,255}));
    connect(HX_cog_IP.TapingSteamFlow,adaptorRealModelicaTSP1. outputReal)
      annotation (Line(points={{-246.2,203.6},{-218,203.6},{-218,223.6}},
                                                                 color={0,0,255}));
    connect(HX_cog_IP.Steam_Tapping_In,fluid2TSPro3. steam_outlet) annotation (
        Line(points={{-253.2,190.2},{-253.2,172.002},{-173.96,172.002}}, color=
            {0,0,255}));
    connect(fluid2TSPro4.steam_inlet,HX_cog_IP. Condensate_Tapping_Out)
      annotation (Line(points={{-172,198},{-186,198},{-186,182},{-250,182},{-250,190.2}},
                          color={0,0,255}));
    connect(HeatNwk_HP_In.y,Heat_HP_Network_Out. m_flow_in)
      annotation (Line(points={{-256,375.6},{-255.9,376},{-255.9,372}},
          color={0,0,127}));
    connect(Heat_HP_Network_Out.ports[1],fluid2TSPro5. port_a)
      annotation (Line(
        points={{-259.5,363},{-259.5,361.86},{-253,361.86}},
        color={0,127,255}));
    connect(HeatNwk_HP_Out.ports[1],fluid2TSPro6. port_b) annotation (
        Line(points={{-235,366},{-234,366},{-234,362},{-239,362},{-239,360}},
          color={0,127,255}));
    connect(Set_Flow_TapSteam_HP.y,adaptorRealModelicaTSP. u)
      annotation (Line(points={{-210,375.6},{-210,364.8}},
                                                      color={0,0,127}));
    connect(fluid2TSPro5.steam_outlet,HX_cog_HP. Water_Cooling_In)
      annotation (Line(points={{-253.002,348.035},{-253.002,335.8},{-235.2,
            335.8}},                                                           color={0,0,255}));
    connect(HX_cog_HP.Water_Cooling_Out,fluid2TSPro6. steam_inlet)
      annotation (Line(points={{-232.2,335.8},{-232.2,340},{-239,340},{-239,346}},  color={255,0,0}));
    connect(HX_cog_HP.TapingSteamFlow,adaptorRealModelicaTSP. outputReal)
      annotation (Line(points={{-228.2,335.6},{-210,335.6},{-210,355.6}},  color={0,0,255}));
    connect(HX_cog_HP.Steam_Tapping_In,fluid2TSPro8. steam_outlet) annotation (
        Line(points={{-235.2,322.2},{-235.2,272},{-208,272},{-208,228.002},{-165.96,
            228.002}}, color={0,0,255}));
    connect(fluid2TSPro7.steam_inlet,HX_cog_HP. Condensate_Tapping_Out)
      annotation (Line(points={{-166,240},{-196,240},{-196,318},{-232,318},{-232,322.2}},
                    color={0,0,255}));
    connect(rampLP.y,HeatNwk_LP_In. m_flow_in) annotation (Line(points={{91.6,230},
            {92,228.8},{82,228.8}},            color={0,0,127}));
    connect(HeatNwk_LP_In.ports[1],fluid2TSPro10. port_a) annotation (Line(
          points={{73,232},{67.86,232},{67.86,229}},    color={0,127,255}));
    connect(HeatNwk_LP_Out.ports[1],fluid2TSPro9. port_b) annotation (
        Line(points={{76,213},{70,213}},   color={0,127,255}));
    connect(adaptorRealModelicaTSP2.u,Set_Flow_TapSteam_LP. y)
      annotation (Line(points={{82.8,198},{91.6,198}},   color={0,0,
            127}));
    connect(HX_cog_LP.fluidInletI1,fluid2TSPro10. steam_outlet) annotation (
        Line(points={{47.8,215.2},{50,215.2},{50,228.998},{54.035,228.998}},
          color={0,0,255}));
    connect(HX_cog_LP.fluidOutletI,fluid2TSPro9. steam_inlet) annotation (Line(points={{47.8,
            212.2},{48,213},{56,213}},                                                                                     color={255,0,0}));
    connect(HX_cog_LP.TapingSteamFlow_CogHP,adaptorRealModelicaTSP2. outputReal)
      annotation (Line(points={{47.6,208.2},{52,208.2},{52,198},{73.6,198}},     color={0,0,255}));
    connect(fluid2TSPro12.steam_outlet,HX_cog_LP. fluidInletI) annotation (Line(
          points={{21.96,213.998},{28,213.998},{28,215.2},{34.2,215.2}},  color
          ={0,0,255}));
    connect(fluid2TSPro11.steam_inlet,HX_cog_LP. fluidOutletI1) annotation (
        Line(points={{22,208},{26,208},{26,206},{30,206},{30,212},{34.2,212}},
          color={0,0,255}));
    connect(HX_HeatInput.FlowControl_LiquidTapingLine,
      Set_Liquid_Tapping_line_Flowrate.                                                 y)
      annotation (Line(points={{-36.2,152.4},{-36.2,146},{-29,146},{-29,140.5}},
                                                                             color={0,0,255}));
    connect(HX_HeatInput.HeatInput2Rankine,ThermalPower_InputToRankine. y)
      annotation (Line(points={{-41.6,152.4},{-41.6,144},{-49,144},{-49,140.5}},
                                                                             color={0,0,255}));
    connect(fluid2TSPro14.steam_outlet,HX_HeatInput. Liquid_Tapping_line)
      annotation (Line(points={{-46.002,176.04},{-46.002,170},{-43.2,170},{-43.2,165.8}},
                      color={0,0,255}));
    connect(fluid2TSPro13.steam_inlet,HX_HeatInput. Turb_IP_In) annotation (
        Line(points={{-36,176},{-36,170},{-40,170},{-40,165.8}},
                                                             color={0,0,255}));
    connect(NSSSctrl.actuatorBus,nsss. actuatorBus) annotation (Line(
        points={{-144.4,314},{-144,314},{-144,308},{-147.5,308},{-147.5,291.64}},
        color={80,200,120},
        thickness=0.5));
    connect(NSSSctrl.sensorBus,nsss. sensorBus) annotation (Line(
        points={{-121.6,314},{-122,314},{-122,310},{-118.5,310},{-118.5,291.64}},
        color={255,219,88},
        thickness=0.5));
    connect(bop.powerConnection,load. port) annotation (Line(
        points={{5.68667,273},{28,273},{28,278},{40,278},{40,272.6}},
        color={0,0,255},
        thickness=0.5));
    connect(bop.flangeB1,fluid2TSPro3. port_a) annotation (Line(points={{
            -70.7667,250},{-70.7667,202},{-146,202},{-146,172},{-158.16,172}},
                                                                  color={0,0,255}));
    connect(bop.flangeA1,fluid2TSPro4. port_b) annotation (Line(points={{
            -11.2333,250},{-14,250},{-14,198},{-156,198}},         color={0,0,255}));
    connect(bop.flangeB2,fluid2TSPro8. port_a) annotation (Line(points={{
            -81.7333,250},{-81.7333,228},{-150.16,228}},color={0,0,255}));
    connect(bop.flangeA4,fluid2TSPro7. port_b) annotation (Line(points={{
            -33.1667,250},{-32,250},{-32,240},{-150,240}},
                                                       color={0,0,255}));
    connect(bop.flangeA3,fluid2TSPro11. port_b) annotation (Line(points={{-0.266667,
            250},{0,250},{0,208},{6,208}},            color={0,0,255}));
    connect(bop.flangeB3,fluid2TSPro12. port_a) annotation (Line(points={{-59.8,250},
            {-59.8,214},{6.16,214}},     color={0,0,255}));
    connect(bop.flangeA2,fluid2TSPro13. port_b) annotation (Line(points={{
            -21.8867,250},{-22,250},{-22,186},{-36,186},{-36,192}},
                                                             color={0,0,255}));
    connect(bop.flangeB4,fluid2TSPro14. port_a) annotation (Line(points={{
            -48.8333,250},{-50,250},{-50,191.84},{-46,191.84}},   color={0,0,
            255}));
    connect(nsss.flangeA,bop. flangeB) annotation (Line(points={{-104,262.84},{
            -100,262.84},{-100,262},{-96,262},{-96,264.786},{-88,264.786}},
                                                                         color=
            {0,0,255}));
    connect(nsss.flangeB,bop. flangeA) annotation (Line(points={{-104,284.8},{
            -100,284.8},{-100,284},{-94,284},{-94,281.214},{-88,281.214}},
                                                                  color={0,0,
            255}));
    connect(BOPctrl.actuatorBus,bop. actuatorBus) annotation (Line(
        points={{-51.3333,312},{-50,312},{-50,304},{-59.8,304},{-59.8,296}},
        color={80,200,120},
        thickness=0.5));
    connect(BOPctrl.sensorBus,bop. sensorBus) annotation (Line(
        points={{-36.3333,312},{-36,312},{-36,308},{-22.2,308},{-22.2,296}},
        color={255,219,88},
        thickness=0.5));
    connect(NPPpowerElectric.y, load.referencePower) annotation (Line(points={{358.8,
            173},{112,173},{112,264},{43.3,264}}, color={0,0,127}));
    connect(Set_Flow_TapSteam_IP.y, adaptorRealModelicaTSP1.u) annotation (Line(
          points={{-318,239.6},{-320,239.6},{-320,232},{-280,232},{-280,260},{
            -218,260},{-218,232.8}}, color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{280,
              140}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{
              280,140}})));
  end Testing;

  model Generatore "Electrical generator"
    import Modelica.Blocks.Interfaces.RealOutput;

    parameter Real eta = 99.8 "Efficiency (percent)";

    // Electrical power variable
    ThermoSysPro.Units.SI.Power Welec "Electrical power produced by the generator";

    // External output connector
    RealOutput P_el
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

    // Single mechanical input connector
    ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Wmec
      annotation (Placement(transformation(extent={{-116,26},{-84,54}}, rotation=0)));

  equation
    // Efficiency bounds
    assert(eta <= 100, "Generator: efficiency over 100% (percent)");
    assert(eta >= 0,   "Generator: efficiency below 0% (percent)");

    // Compute electrical power
    Welec = Wmec.signal * eta/100;
    P_el = Welec;

  end Generatore;

  model System_7L
    parameter Real N_HTSE = 15 "Number of HTSE Modules in the H2 Plant";
    parameter Integer N_boiler=3 "Number of thermal nodes in the boiler";

    MethanationReactor             methanationReactor(conversionEfficiency=0.8)
      annotation (Placement(transformation(extent={{-48,-118},{30,-40}})));
    MethanationControlInput             methanationControlInput(stoichRatio=8, T=0)
             annotation (Placement(transformation(extent={{-194,-116},{-116,-38}})));
    H2_Buffer bufferH2(stock=0.1, Content(start=0))
                                          annotation (Placement(Placement(
            transformation(extent={{0,20},{0,15}})), transformation(extent={{-306,
              -54},{-248,-112}})));
    CH4_Buffer bufferCH4(Content(start=0))  annotation (Placement(Placement(
            transformation(extent={{0,20},{0,15}})), transformation(extent={{250,-28},
              {308,-86}})));

    TurboGas                      gasTurbine(
      maxPower=47e6,
      flueGasNomFlowRate=122.8,
      flueGasMinFlowRate=90.8,
      fuelNomFlowRate=2.42,
      fuelIntFlowRate=1.416,
      fuelMinFlowRate=0.916,
      fuelOffFlowRate=0.02)                  annotation (Placement(
          transformation(extent={{80,-132},{124,-88}},
                                                   rotation=0)));
    ThermoPower.Gas.SinkPressure
                          sinkP(redeclare package Medium =
          ThermoPower.Media.FlueGas) annotation (Placement(transformation(
            extent={{170,-98},{190,-78}},
                                      rotation=0)));
    ThermoPower.PowerPlants.HRSG.Components.StateReader_gas stateReader_gas(
        redeclare package Medium = ThermoPower.Media.FlueGas) annotation (
        Placement(transformation(extent={{128,-114},{148,-94}},
                                                           rotation=0)));
    Modelica.Blocks.Sources.RealExpression NPPpowerElectric(y=bop.powerSensor.power)
      annotation (Placement(transformation(
          extent={{-72,-17},{72,17}},
          rotation=180,
          origin={362,323})));

    Control_Room control_Room(
      n_HTSE=N_HTSE,
      manualTable=[0,0,0,100,0; 1,1,0.600000000000001,27.4538632753312,
          69608075.7729453; 2,1,0.600000000000001,27.5169299289537,
          70572979.6598991; 3,1,0.600000000000001,27.8251462208537,
          72255093.3477483; 4,1,0.600000000000001,28.4008251916282,
          74549284.9895404; 5,1,0.600000000000001,30.4647984145394,
          76293627.5914502; 6,1,0.600000000000001,38.9773541002316,
          85582561.6314679; 7,1,0.793568221643726,73.0609826370759,
          102117904.558753; 8,0.999952998578923,0.816714566589801,
          75.2050573236502,101137475.283212; 9,1,0.600000000000001,
          21.1338230156334,101918549.625448; 10,1,0.600000000000001,
          6.24972371248039,99091351.9754837; 11,1,0.600000000000001,-9.20361555455061,
          94074002.2273139; 12,1,0.600000000000001,-16.5485515979708,
          81968012.4291393; 13,1,0.600000000000001,22.9816050216017,
          69770462.3063141; 14,1,0.600000000000001,12.5431623038572,
          57545575.4254187; 15,1,0.600000000000001,1.5646323314649,
          46056938.6082648; 16,1,0.600000000000001,15.0201114953555,
          39334935.8296207; 17,1,0.600000000000001,26.8822077030957,
          38295528.8938766; 18,1,0.600000000000001,33.1815330102518,
          47753106.4178218; 19,0.999554168938375,0.954075249612258,
          82.2128360881281,65438368.1153335; 20,0.958935290530722,1,
          104.955621739638,72062544.4473139; 21,1,0.65961482336269,
          66.0930476563832,69847938.0548716; 22,1,0.600000000000001,
          49.5851881750129,69235294.7964405; 23,1,0.600000000000001,
          36.2787512963399,69206154.4076984; 24,1,0.600000000000001,
          30.0894166813869,68841062.5915437],
      n_Reactors=2)
      annotation (Placement(transformation(extent={{46,106},{-82,228}})));
    Modelica.Blocks.Sources.RealExpression Pelec_HTSE(y=h2plant.hTSE_module.ElectricityPower.y)
      annotation (Placement(transformation(extent={{450,32},{340,70}})));
    Modelica.Blocks.Sources.RealExpression Pelec_TURBOGAS(y=gasTurbine.P_el)
      annotation (Placement(transformation(extent={{450,182},{340,220}})));
    Modelica.Blocks.Sources.RealExpression heat2HTSE1(y=HX_cog_IP.Hx_Hybrid.W/
          N_boiler)
      annotation (Placement(transformation(extent={{55,-19},{-55,19}},
          rotation=0,
          origin={-335,115})));
    H2plant h2plant(N_HTSE=N_HTSE, N_boiler=N_boiler)
      annotation (Placement(transformation(extent={{-488,-94},{-390,12}})));
    inner ThermoPower.System system(initOpt=ThermoPower.Choices.Init.Options.steadyState)
      annotation (Placement(transformation(extent={{-26,454},{-6,474}})));
    ThermoPower.Electrical.Load load(Pnom=170e6, usePowerInput=true)
      annotation (Placement(transformation(extent={{-26,404},{-46,424}})));
    Modelica.Fluid.Sources.MassFlowSource_h Heat_IP_Network_Out(
      redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
      use_m_flow_in=true,
      use_h_in=false,
      m_flow=100,
      h=135000,
      nPorts=1) annotation (Placement(transformation(
          extent={{-4.5,-4.5},{4.5,4.5}},
          rotation=270,
          origin={-339.5,385.5})));
    Modelica.Blocks.Sources.Ramp HeatNwk_IP_In(
      height=120,
      duration=900,
      offset=0.01,
      startTime=100) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=270,
          origin={-338,398})));
    Modelica.Fluid.Sources.Boundary_ph HeatNwk_IP_Out(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=false,
      p=1500000,
      nPorts=1) annotation (Placement(transformation(
          extent={{-3,-3},{3,3}},
          rotation=270,
          origin={-321,387})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.Fluid2TSPro fluid2TSPro1
      annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=90,
          origin={-341,371})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.TSPro2Fluid fluid2TSPro2
      annotation (Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=90,
          origin={-325,371})));
    TANDEM.SMR.BOP.BOP_TSPro.FMU_Coupling.Adaptor4FMU.AdaptorRealModelicaTSP adaptorRealModelicaTSP1
      annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=270,
          origin={-294,378})));
    TANDEM.SMR.BOP.BOP_TSPro.BOP_2Plug.HX_cog HX_cog_IP(
      Hx_Hybrid(
        DPc(start=1.1937366759301423E-07, displayUnit="bar"),
        DPf(start=0.059666027103045215, displayUnit="bar"),
        Ec(h(start=2639609.877779146)),
        Sc(h_vol(start=711083.3242149337)),
        DPfc(start=1.1940782842197216E-07, displayUnit="bar"),
        DPff(start=0.0596661726252597, displayUnit="bar")),
      TCond_Tap(C2(h_vol(start=711083.3242149337))),
      Vv_Tap(C2(h_vol(start=711083.3242149337))),
      Condensate_Tapping_Out(h_vol(start=711083.3242149337)),
      Steam_Tapping_In(h(start=2639609.877779149)),
      Vol_Tap(h(start=2639609.877779146)))
      annotation (Placement(transformation(extent={{-332,340},{-318,354}})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.Fluid2TSPro fluid2TSPro3(
        steam_outlet(h(start=2944000.0)), port_a(h_outflow(start=
              2962802.891927479))) annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=180,
          origin={-242,322})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.TSPro2Fluid fluid2TSPro4
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=0,
          origin={-240,348})));
    Modelica.Blocks.Sources.Ramp HeatNwk_HP_In(
      height=120,
      duration=900,
      offset=0.01,
      startTime=100) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=270,
          origin={-332,530})));
    Modelica.Fluid.Sources.MassFlowSource_h Heat_HP_Network_Out(
      redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
      use_m_flow_in=true,
      use_h_in=false,
      m_flow=100,
      h=135000,
      nPorts=1) annotation (Placement(transformation(
          extent={{-4.5,-4.5},{4.5,4.5}},
          rotation=270,
          origin={-335.5,517.5})));
    Modelica.Fluid.Sources.Boundary_ph HeatNwk_HP_Out(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=false,
      p=1500000,
      nPorts=1) annotation (Placement(transformation(
          extent={{-3,-3},{3,3}},
          rotation=270,
          origin={-311,519})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.Fluid2TSPro          fluid2TSPro5 annotation (
        Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=270,
          origin={-329,505})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.TSPro2Fluid          fluid2TSPro6
                                                           annotation (
        Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=90,
          origin={-315,503})));
    TANDEM.SMR.BOP.BOP_TSPro.FMU_Coupling.Adaptor4FMU.AdaptorRealModelicaTSP
      adaptorRealModelicaTSP annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=270,
          origin={-286,510})));
    Modelica.Blocks.Sources.Ramp Set_Flow_TapSteam_HP(
      height=0,
      duration=900,
      offset=0.001,
      startTime=100) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=270,
          origin={-286,530})));
    TANDEM.SMR.BOP.BOP_TSPro.BOP_2Plug.HX_cog
                     HX_cog_HP(
      Hx_Hybrid(
        DPc(start=2.4435370387197308E-08, displayUnit="bar"),
        DPf(start=0.05962862289370117, displayUnit="bar"),
        Sc(h_vol(start=1122142.992781656)),
        Ec(h(start=2944106.3643035744)),
        DPfc(start=2.452980926549997E-08, displayUnit="bar"),
        DPff(start=0.05962919799262121, displayUnit="bar")),
      Vv_Tap(C2(h_vol(start=1122142.992781656))),
      TCond_Tap(C2(h_vol(start=1122142.992781656))),
      Steam_Tapping_In(h(start=2944106.3643035744)),
      Vol_Tap(h(start=2944106.3643035744)))           annotation (Placement(transformation(extent={{-314,
              472},{-300,486}})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.TSPro2Fluid fluid2TSPro7
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=0,
          origin={-234,390})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.Fluid2TSPro fluid2TSPro8(
        steam_outlet(h(start=2944000.0)), port_a(h_outflow(start=
              2962802.891927479))) annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=180,
          origin={-234,378})));
    Modelica.Fluid.Sources.MassFlowSource_h HeatNwk_LP_In(
      redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
      use_m_flow_in=true,
      use_h_in=false,
      m_flow=100,
      h=135000,
      nPorts=1) annotation (Placement(transformation(
          extent={{-4.5,-4},{4.5,4}},
          rotation=180,
          origin={1.5,382})));
    Modelica.Blocks.Sources.Ramp rampLP(
      height=120,
      duration=900,
      offset=0.01,
      startTime=100) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=180,
          origin={20,380})));
    Modelica.Fluid.Sources.Boundary_ph HeatNwk_LP_Out(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=false,
      p=1500000,
      nPorts=1) annotation (Placement(transformation(
          extent={{-3,-3},{3,3}},
          rotation=180,
          origin={3,363})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.TSPro2Fluid          fluid2TSPro9
                                                           annotation (
        Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=0,
          origin={-13,363})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.Fluid2TSPro          fluid2TSPro10
                                                                                     annotation (
        Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=0,
          origin={-15,379})));
    TANDEM.SMR.BOP.BOP_TSPro.FMU_Coupling.Adaptor4FMU.AdaptorRealModelicaTSP
      adaptorRealModelicaTSP2
                             annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=180,
          origin={2,348})));
    Modelica.Blocks.Sources.Ramp Set_Flow_TapSteam_LP(
      height=0,
      duration=900,
      offset=0.001,
      startTime=100) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=180,
          origin={20,348})));
    TANDEM.SMR.BOP.BOP_TSPro.BOP_2Plug.HX_cog_LP
                        HX_cog_LP(
      Hx_Hybrid_LP(
        DPc(start=1.0213770701459113E-06, displayUnit="bar"),
        DPf(start=0.05977430533560828, displayUnit="bar"),
        Ec(h(start=2621766.47834097)),
        Sc(h_vol(start=391984.5158094587)),
        DPfc(start=1.021218703891956E-06, displayUnit="bar"),
        DPff(start=0.05977420587861938, displayUnit="bar")),
      TCond_Tap_LP(C2(h_vol(start=391984.5158094587))),
      Vv_Tap_LP(C2(h_vol(start=391984.5158094587))),
      Vol7(h(start=2621766.47834097)),
      fluidInletI(h(start=2621766.4783409717)),
      fluidOutletI1(h_vol(start=391984.5158094587)))
                                          annotation (Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=270,
          origin={-35,361})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.TSPro2Fluid fluid2TSPro11
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=180,
          origin={-62,358})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.Fluid2TSPro fluid2TSPro12(
        steam_outlet(h(start=2944000.0)), port_a(h_outflow(start=
              2962802.891927479))) annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=0,
          origin={-62,364})));
    TANDEM.SMR.BOP.BOP_TSPro.BOP_2Plug.HX_HeatInput
                           HX_HeatInput(
      T_HeatInput(C2(h_vol(start=466374.3984095717))),
      Vv_HeatInput(C2(h_vol(start=466374.3984095717))),
      Liquid_Tapping_line(h(start=465374.3984095717)),
      Vol_Tap(h(start=466374.3984095717)))
      annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=180,
          origin={-115,309})));
    ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Set_Liquid_Tapping_line_Flowrate(k=1e-3)
      annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=90,
          origin={-105,285})));
    ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante ThermalPower_InputToRankine
      annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=90,
          origin={-125,285})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.TSPro2Fluid fluid2TSPro13
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=90,
          origin={-112,334})));
    TANDEM.SMR.BOP.BOP_TSPro.AdaptatorForMSL.Fluid.Fluid2TSPro fluid2TSPro14(
        steam_outlet(h(start=2944000.0)), port_a(h_outflow(start=
              2962802.891927479))) annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=270,
          origin={-122,334})));
    TANDEM.SMR.NSSS.NSSS_ThermoPower.Control.NSSSctrl_ex2
                         NSSSctrl
      annotation (Placement(transformation(extent={{-228,464},{-190,496}})));
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
          heatTransfer(gamma(start=14586.649512440295)),
          h(start={687347.8935488948,1064946.1647611712,1341716.155222091,
                1585307.4080712595,1769403.3275958602,1961873.102383314,
                2195618.6257879734,2419768.3172225566,2620868.6353172557,
                2820118.24037197,2944106.3643035744})), Primary(p(start=
                14766715.218693856, displayUnit="bar"), wall(T(start={
                  589.4082287819939,587.5173057493705,585.2231053970795,
                  582.9825962654701,583.5859133445866,579.8971845995204,
                  577.5967200282101,575.5710566193154,573.6111123867778,
                  565.3798590723168}, displayUnit="degC")))),
      htc2(fixed=false, start=14586.649512440295),
      core(neutronicKinetics(P(start=540e6, fixed=true)), fuel(
          Tc(start={598.8485267209098,601.4035526585864,603.9211273787487,
                606.3992916001216,608.8359984035769,611.2291109638,
                613.576395652504,615.8755068844395,618.1239590989708,
                620.3190808301662}, displayUnit="degC"),
          Tci(start={606.5468900444794,609.0919223973908,611.599670414378,
                614.0681814774575,616.495415629274,618.879243312943,
                621.2174385015434,623.5076636023115,625.7474415456983,
                627.934110031119}, displayUnit="degC"),
          Tco(start={591.6609396860848,594.2252961473115,596.7520455818084,
                599.2392224871089,601.6847734442164,604.0865548416372,
                606.4423259540589,608.7497337340378,611.0062846932235,
                613.2092988084463}, displayUnit="degC"),
          Tvol(start=[1105.9751157884032,959.4674202468113,900.8840483513684,
                846.325544710997,794.7866604051272; 1108.908088571398,
                962.0627959886949,903.3472039996595,848.6674820220086,
                797.0158678417474; 1111.8011667195126,964.622666603949,
                905.7765762909835,850.9772195729826,799.2143538408656;
                1114.6519422463166,967.1449108512938,908.1701559527464,
                853.2528504644085,801.3803064399116; 1117.457900571859,
                969.6273136675054,910.5258449007742,855.4923835683683,
                803.5118336960317; 1120.2164178332905,972.0675637916177,
                912.8414539880546,857.6937413917203,805.6069616556396;
                1122.924752880846,974.4632466859515,915.1146962897845,
                859.854753695151,807.663628284036; 1125.5800297344547,
                976.8118290194394,917.3431723821283,861.9731435013649,
                809.6796701518058; 1128.1792051179127,979.1106299560945,
                919.5243431026096,864.0465012048671,811.6527977990784;
                1130.7190151479756,981.356774016376,921.6554848302269,
                866.0722420690554,813.58055529342], displayUnit="degC"))),
      flangeB(h_outflow(start=2944106.3643035744)),
      pump(q_single(start=0.8498079349769984), h(start=1336699.0456428102)),
      flangeA(h_outflow(start=1064946.1647611712)),
      pressurizer(pressurizer(h(start=1862126.0574145121))))
      annotation (Placement(transformation(extent={{-238,406},{-180,442}})));
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
      annotation (Placement(transformation(extent={{-134,462},{-104,488}})));

    TANDEM.SMR.BOP.BOP_POLIMI.BOPdyn_fluid
                 bop(
      LP_TAV(allowFlowReversal=false, dp(start=49976.15459620149, displayUnit=
              "bar")),
      CNDpump(dp(start=784312.2193723671, displayUnit="bar"), h(start=
              164353.2596440803)),
      FWpump(
        dp(start=4019700.053627746, displayUnit="bar"),
        h(start=470048.16904780775),
        inletFluidState(h(start=464762.74452770816), p(start=674700.0,
              displayUnit="bar")),
        q_single(start=0.25238031865554933)),
      FWtank(hout(start=464762.74452770816), inlet(m_flow(start={
                182.55809058420135,20.779072368963686,11.665027087211513,
                25.003329372318213,0.0010000000474974513}))),
      HP_TAV(
        dp(start=83468.38568951283, displayUnit="bar"),
        w(start=216.87287270012862),
        fluidState(h(start=2944106.364303575)),
        outlet(p(start=4416531.614310487, displayUnit="bar"))),
      LPTurbine1(
        steamState_in(p(start=636783.2762532821, displayUnit="bar")),
        eta_iso_nom=0.9,
        corrWet=true,
        corrFlow=true,
        eta_iso(start=0.8913592492841899)),
      LPTurbine2(
        w(start=166.06766731246455),
        eta_iso_nom=0.9,
        corrWet=true,
        corrFlow=true,
        steamState_in(p(start=79250.60705941985, displayUnit="bar")),
        eta_iso(start=0.845811081811772)),
      hp_fw(shell_2ph(h(start={2639610.136857381,2574398.6911774203,
                2492056.5434580203,2388110.8926207623,2256942.7322803335,
                2091511.738165602,1883032.6478808254,1620613.2455945762,
                1290889.9721959964,877754.7983572524,553815.7396726587}), p(
              start=757148.917031315, displayUnit="bar")), flangeB1(h_outflow(
              start=687342.7188409794))),
      lp_fw(shell_2ph(h(start={2621766.536753741,2556772.5434357887,
                2474014.9230734445,2368757.1377552887,2235082.33993792,
                2065660.872271856,1851523.66657229,1581898.6840277603,
                1244230.2827270308,824623.739009895,333062.74404833495}), p(
              start=80244.03752206039, displayUnit="bar")), flangeB(m_flow(
              start=-16.50412201408733))),
      mixer(h(start=2763166.530261766)),
      moistureSeparator(steam(h_outflow(start=2763179.113822877), p(start=
                707810.5498582933, displayUnit="bar")), inlet(p(start=
                707172.7624351135, displayUnit="bar"))),
      pressDropLin3(state(d(start=902.1555302385668, displayUnit="g/cm3"))),
      rh(shell_2ph(h(start={2944106.364303575,2890364.758696105,
                2854460.031102937,2829994.8508293987,2813089.0952963904,
                2769066.8963323813,2684241.1813017344,2534788.3606152576,
                2272728.532176967,1816479.0360469588,1049549.8820976075}))),
      valve_SGin(dp(start=100351.7920709017, displayUnit="bar"), fluidState(p(
              start=4656083.644885505, displayUnit="bar"))),
      HPTurbine(
        eta_iso_nom=0.9,
        corrWet=true,
        corrFlow=true,
        eta_iso(start=0.8722649294586934)),
      sensT1_2(T(start=300 + 273.15)),
      LP_TAV1(dp(start=993.4304626405356, displayUnit="bar")),
      flangeA1(h_outflow(start=710502.0457445189)),
      mixer2(h(start=687344.5310518404)),
      valveLiq(dp(start=42448.91703131504, displayUnit="bar")),
      flowSplit2(out2(m_flow(start=-16.503145774935035))),
      mixer1(h(start=2147066.3953712382)),
      valveLiq1(dp(start=73244.03752206039, displayUnit="bar")))
      annotation (Placement(transformation(extent={{-164,400},{-70,446}})));
    FossilConsumptionEval fossilConsumptionEval1(efficiency=0.80, demand=false)
      annotation (Placement(transformation(extent={{34,16},{86,68}})));
  equation

    connect(methanationControlInput.n_H2_out,methanationReactor. n_H2_in)
      annotation (Line(points={{-112.1,-57.5},{-60,-57.5},{-60,-59.5},{-51.9,-59.5}},
                                                          color={0,0,127}));
    connect(methanationControlInput.n_CO2_out,methanationReactor. n_CO2_in)
      annotation (Line(points={{-112.1,-96.5},{-60,-96.5},{-60,-98.5},{-51.9,-98.5}},
                                                          color={0,0,127}));
    connect(bufferH2.mass_flow_out,methanationControlInput. m_H2_in)
      annotation (Line(points={{-243.65,-80.97},{-208,-80.97},{-208,-77},{-197.9,-77}},
          color={0,0,127}));
    connect(methanationReactor.m_flow_rate,bufferCH4. mass_flow_in) annotation (
       Line(points={{33.9,-59.5},{228,-59.5},{228,-57},{244.2,-57}},
                                                                color={0,0,127}));
    connect(stateReader_gas.inlet,gasTurbine. flueGasOut) annotation (Line(
        points={{132,-104},{124,-104},{124,-92.4}},
        color={159,159,223},
        thickness=0.5));
    connect(stateReader_gas.outlet,sinkP. flange) annotation (Line(
        points={{144,-104},{160,-104},{160,-88},{170,-88}},
        color={159,159,223},
        thickness=0.5));
    connect(gasTurbine.fuelFlowRateOut, bufferCH4.mass_flow_out) annotation (
        Line(points={{126.2,-112.2},{124,-112.2},{124,-144},{279.29,-144},{279.29,
            -91.51}}, color={0,0,127}));
    connect(NPPpowerElectric.y, control_Room.P_nuc) annotation (Line(points={{282.8,
            323},{58.8,323},{58.8,215.8}}, color={0,0,127}));
    connect(control_Room.P_HTSE, Pelec_HTSE.y) annotation (Line(points={{58.8,118.2},
            {58.8,80},{320,80},{320,51},{334.5,51}},
                                              color={0,0,127}));
    connect(control_Room.P_turbine, Pelec_TURBOGAS.y) annotation (Line(points={{58.8,
            191.4},{320,191.4},{320,201},{334.5,201}}, color={0,0,127}));
    connect(methanationReactor.PCS, gasTurbine.HHV) annotation (Line(points={{33.9,
            -106.3},{60,-106.3},{60,-101.2},{77.8,-101.2}},
                                                      color={0,0,127}));
    connect(methanationReactor.PCI, gasTurbine.LHV) annotation (Line(points={{33.9,
            -94.6},{77.8,-94.6}},                 color={0,0,127}));
    connect(h2plant.H2_plant_output, bufferH2.mass_flow_in) annotation (Line(
          points={{-380.2,-41},{-380.2,-97.5},{-311.8,-97.5}}, color={0,0,127}));
    connect(heat2HTSE1.y, h2plant.H2_plant_Heat_Input) annotation (Line(points={{-395.5,
            115},{-439,115},{-439,22.6}},    color={0,0,127}));
    connect(HeatNwk_IP_In.y,Heat_IP_Network_Out. m_flow_in)
      annotation (Line(points={{-338,393.6},{-335.9,393.6},{-335.9,390}},
          color={0,0,127}));
    connect(Heat_IP_Network_Out.ports[1],fluid2TSPro1. port_a)
      annotation (Line(
        points={{-339.5,381},{-341,381},{-341,377.86}},
        color={0,127,255}));
    connect(HeatNwk_IP_Out.ports[1],fluid2TSPro2. port_b) annotation (
        Line(points={{-321,384},{-320,384},{-320,378},{-325,378}},
                                                       color={0,127,
            255}));
    connect(fluid2TSPro1.steam_outlet,HX_cog_IP. Water_Cooling_In)
      annotation (Line(points={{-340.998,364.035},{-340.998,353.8},{-329.2,
            353.8}},                                                                 color={0,0,255}));
    connect(fluid2TSPro2.steam_inlet,HX_cog_IP. Water_Cooling_Out) annotation (Line(points={{-325,
            364},{-324,364},{-324,360},{-326.2,360},{-326.2,353.8}},                                                                color={0,0,255}));
    connect(HX_cog_IP.TapingSteamFlow,adaptorRealModelicaTSP1. outputReal)
      annotation (Line(points={{-322.2,353.6},{-294,353.6},{-294,373.6}},
                                                                 color={0,0,255}));
    connect(HX_cog_IP.Steam_Tapping_In,fluid2TSPro3. steam_outlet) annotation (
        Line(points={{-329.2,340.2},{-329.2,322.002},{-249.96,322.002}}, color=
            {0,0,255}));
    connect(fluid2TSPro4.steam_inlet,HX_cog_IP. Condensate_Tapping_Out)
      annotation (Line(points={{-248,348},{-262,348},{-262,332},{-326,332},{
            -326,340.2}}, color={0,0,255}));
    connect(HeatNwk_HP_In.y,Heat_HP_Network_Out. m_flow_in)
      annotation (Line(points={{-332,525.6},{-331.9,526},{-331.9,522}},
          color={0,0,127}));
    connect(Heat_HP_Network_Out.ports[1],fluid2TSPro5. port_a)
      annotation (Line(
        points={{-335.5,513},{-335.5,511.86},{-329,511.86}},
        color={0,127,255}));
    connect(HeatNwk_HP_Out.ports[1],fluid2TSPro6. port_b) annotation (
        Line(points={{-311,516},{-310,516},{-310,512},{-315,512},{-315,510}},
          color={0,127,255}));
    connect(Set_Flow_TapSteam_HP.y,adaptorRealModelicaTSP. u)
      annotation (Line(points={{-286,525.6},{-286,514.8}},
                                                      color={0,0,127}));
    connect(fluid2TSPro5.steam_outlet,HX_cog_HP. Water_Cooling_In)
      annotation (Line(points={{-329.002,498.035},{-329.002,485.8},{-311.2,
            485.8}},                                                           color={0,0,255}));
    connect(HX_cog_HP.Water_Cooling_Out,fluid2TSPro6. steam_inlet)
      annotation (Line(points={{-308.2,485.8},{-308.2,490},{-315,490},{-315,496}},  color={255,0,0}));
    connect(HX_cog_HP.TapingSteamFlow,adaptorRealModelicaTSP. outputReal)
      annotation (Line(points={{-304.2,485.6},{-286,485.6},{-286,505.6}},  color={0,0,255}));
    connect(HX_cog_HP.Steam_Tapping_In,fluid2TSPro8. steam_outlet) annotation (
        Line(points={{-311.2,472.2},{-311.2,422},{-284,422},{-284,378.002},{
            -241.96,378.002}},
                       color={0,0,255}));
    connect(fluid2TSPro7.steam_inlet,HX_cog_HP. Condensate_Tapping_Out)
      annotation (Line(points={{-242,390},{-272,390},{-272,468},{-308,468},{
            -308,472.2}},
                    color={0,0,255}));
    connect(rampLP.y,HeatNwk_LP_In. m_flow_in) annotation (Line(points={{15.6,
            380},{16,378.8},{6,378.8}},        color={0,0,127}));
    connect(HeatNwk_LP_In.ports[1],fluid2TSPro10. port_a) annotation (Line(
          points={{-3,382},{-8.14,382},{-8.14,379}},    color={0,127,255}));
    connect(HeatNwk_LP_Out.ports[1],fluid2TSPro9. port_b) annotation (
        Line(points={{0,363},{-6,363}},    color={0,127,255}));
    connect(adaptorRealModelicaTSP2.u,Set_Flow_TapSteam_LP. y)
      annotation (Line(points={{6.8,348},{15.6,348}},    color={0,0,
            127}));
    connect(HX_cog_LP.fluidInletI1,fluid2TSPro10. steam_outlet) annotation (
        Line(points={{-28.2,365.2},{-26,365.2},{-26,378.998},{-21.965,378.998}},
          color={0,0,255}));
    connect(HX_cog_LP.fluidOutletI,fluid2TSPro9. steam_inlet) annotation (Line(points={{-28.2,
            362.2},{-28,363},{-20,363}},                                                                                   color={255,0,0}));
    connect(HX_cog_LP.TapingSteamFlow_CogHP,adaptorRealModelicaTSP2. outputReal)
      annotation (Line(points={{-28.4,358.2},{-24,358.2},{-24,348},{-2.4,348}},  color={0,0,255}));
    connect(fluid2TSPro12.steam_outlet,HX_cog_LP. fluidInletI) annotation (Line(
          points={{-54.04,363.998},{-48,363.998},{-48,365.2},{-41.8,365.2}},
                                                                          color
          ={0,0,255}));
    connect(fluid2TSPro11.steam_inlet,HX_cog_LP. fluidOutletI1) annotation (
        Line(points={{-54,358},{-50,358},{-50,356},{-46,356},{-46,362},{-41.8,
            362}},
          color={0,0,255}));
    connect(HX_HeatInput.FlowControl_LiquidTapingLine,
      Set_Liquid_Tapping_line_Flowrate.                                                 y)
      annotation (Line(points={{-112.2,302.4},{-112.2,296},{-105,296},{-105,
            290.5}},                                                         color={0,0,255}));
    connect(HX_HeatInput.HeatInput2Rankine,ThermalPower_InputToRankine. y)
      annotation (Line(points={{-117.6,302.4},{-117.6,294},{-125,294},{-125,
            290.5}},                                                         color={0,0,255}));
    connect(fluid2TSPro14.steam_outlet,HX_HeatInput. Liquid_Tapping_line)
      annotation (Line(points={{-122.002,326.04},{-122.002,320},{-119.2,320},{
            -119.2,315.8}},
                      color={0,0,255}));
    connect(fluid2TSPro13.steam_inlet,HX_HeatInput. Turb_IP_In) annotation (
        Line(points={{-112,326},{-112,320},{-116,320},{-116,315.8}},
                                                             color={0,0,255}));
    connect(NSSSctrl.actuatorBus,nsss. actuatorBus) annotation (Line(
        points={{-220.4,464},{-220,464},{-220,458},{-223.5,458},{-223.5,441.64}},
        color={80,200,120},
        thickness=0.5));
    connect(NSSSctrl.sensorBus,nsss. sensorBus) annotation (Line(
        points={{-197.6,464},{-198,464},{-198,460},{-194.5,460},{-194.5,441.64}},
        color={255,219,88},
        thickness=0.5));
    connect(bop.powerConnection,load. port) annotation (Line(
        points={{-70.3133,423},{-48,423},{-48,428},{-36,428},{-36,422.6}},
        color={0,0,255},
        thickness=0.5));
    connect(bop.flangeB1,fluid2TSPro3. port_a) annotation (Line(points={{
            -146.767,400},{-146.767,352},{-222,352},{-222,322},{-234.16,322}},
                                                                  color={0,0,255}));
    connect(bop.flangeA1,fluid2TSPro4. port_b) annotation (Line(points={{
            -87.2333,400},{-90,400},{-90,348},{-232,348}},         color={0,0,255}));
    connect(bop.flangeB2,fluid2TSPro8. port_a) annotation (Line(points={{
            -157.733,400},{-157.733,378},{-226.16,378}},color={0,0,255}));
    connect(bop.flangeA4,fluid2TSPro7. port_b) annotation (Line(points={{
            -109.167,400},{-108,400},{-108,390},{-226,390}},
                                                       color={0,0,255}));
    connect(bop.flangeA3,fluid2TSPro11. port_b) annotation (Line(points={{
            -76.2667,400},{-76,400},{-76,358},{-70,358}},
                                                      color={0,0,255}));
    connect(bop.flangeB3,fluid2TSPro12. port_a) annotation (Line(points={{-135.8,
            400},{-135.8,364},{-69.84,364}},
                                         color={0,0,255}));
    connect(bop.flangeA2,fluid2TSPro13. port_b) annotation (Line(points={{
            -97.8867,400},{-98,400},{-98,336},{-112,336},{-112,342}},
                                                             color={0,0,255}));
    connect(bop.flangeB4,fluid2TSPro14. port_a) annotation (Line(points={{
            -124.833,400},{-126,400},{-126,341.84},{-122,341.84}},color={0,0,
            255}));
    connect(nsss.flangeA,bop. flangeB) annotation (Line(points={{-180,412.84},{
            -176,412.84},{-176,412},{-172,412},{-172,414.786},{-164,414.786}},
                                                                         color=
            {0,0,255}));
    connect(nsss.flangeB,bop. flangeA) annotation (Line(points={{-180,434.8},{
            -176,434.8},{-176,434},{-170,434},{-170,431.214},{-164,431.214}},
                                                                  color={0,0,
            255}));
    connect(BOPctrl.actuatorBus,bop. actuatorBus) annotation (Line(
        points={{-127.333,462},{-126,462},{-126,454},{-135.8,454},{-135.8,446}},
        color={80,200,120},
        thickness=0.5));
    connect(BOPctrl.sensorBus,bop. sensorBus) annotation (Line(
        points={{-112.333,462},{-112,462},{-112,458},{-98.2,458},{-98.2,446}},
        color={255,219,88},
        thickness=0.5));
    connect(NPPpowerElectric.y, load.referencePower) annotation (Line(points={{
            282.8,323},{36,323},{36,414},{-32.7,414}}, color={0,0,127}));
    connect(fossilConsumptionEval1.mass_flow_rate_required, bufferCH4.mass_flow_to_grid)
      annotation (Line(points={{91.2,42.26},{279,42.26},{279,-22.2}}, color={0,0,127}));
    connect(methanationReactor.PCI, fossilConsumptionEval1.LHV) annotation (Line(
          points={{33.9,-94.6},{60,-94.6},{60,10.54}}, color={0,0,127}));
    connect(control_Room.fossil_fuel_demand, fossilConsumptionEval1.power_demand)
      annotation (Line(points={{-88.4,118.2},{-104,118.2},{-104,42.26},{28.8,42.26}},
          color={0,0,127}));
    connect(control_Room.turbine_load, gasTurbine.GTLoad) annotation (Line(points={{-88.4,
            167},{-112,167},{-112,-28},{-92,-28},{-92,-136},{68,-136},{68,-110},{80,
            -110}},     color={0,0,127}));
    connect(control_Room.setpoint_H2, h2plant.H2_plant_setpoint) annotation (Line(
          points={{-88.4,191.4},{-497.8,191.4},{-497.8,-41}}, color={0,0,127}));
    connect(control_Room.mflow_tapSteam, adaptorRealModelicaTSP1.u) annotation (
        Line(points={{-88.4,142.6},{-294,142.6},{-294,382.8}}, color={0,0,127}));
    annotation (Diagram(coordinateSystem(extent={{-560,-220},{540,560}})), Icon(
          coordinateSystem(extent={{-560,-220},{540,560}})),
      experiment(StopTime=90000, __Dymola_Algorithm="Dassl"));
  end System_7L;

  model CH4_Buffer
    Modelica.Blocks.Interfaces.RealInput mass_flow_in
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealInput mass_flow_out
      annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={0,120}), iconTransformation(
          extent={{-19,-19},{19,19}},
          rotation=-90,
          origin={1,119})));
    Modelica.Blocks.Interfaces.RealInput mass_flow_to_grid
      annotation (Placement(transformation(extent={{20,-20},{-20,20}},
          rotation=-90,
          origin={0,-120})));

    Real Content(start=0) "Amount of mass stored in the buffer";

  equation
    // Mass balance differential equation
    der(Content) = mass_flow_in - mass_flow_out - mass_flow_to_grid;

    annotation (Diagram(graphics={
          Ellipse(
            extent={{-100,100},{100,50}},
            lineColor={28,108,200},
            fillColor={255,255,85},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-100,-50},{100,-100}},
            lineColor={28,108,200},
            fillColor={255,255,85},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,76},{100,-74}},
            lineColor={28,108,200},
            fillColor={255,255,85},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-52,32},{58,-24}},
            textColor={28,108,200},
            textString="SynGas",
            textStyle={TextStyle.Bold})}), Icon(graphics={
          Ellipse(
            extent={{-98,100},{102,50}},
            lineColor={28,108,200},
            fillColor={255,255,85},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-98,-50},{102,-100}},
            lineColor={28,108,200},
            fillColor={255,255,85},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-98,76},{102,-74}},
            lineColor={28,108,200},
            fillColor={255,255,85},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-50,32},{60,-24}},
            textColor={28,108,200},
            textString="SynGas",
            textStyle={TextStyle.Bold})}));
  end CH4_Buffer;

  model TurboGas
    extends ThermoPower.PowerPlants.GasTurbine.Interfaces.GasTurbineSimplified;

    parameter Modelica.Units.SI.Power maxPower=235e6;
    parameter Modelica.Units.SI.MassFlowRate flueGasNomFlowRate=614 "Nominal flue gas flow rate";
    parameter Modelica.Units.SI.MassFlowRate flueGasMinFlowRate=454 "Minimum flue gas flow rate";
    parameter Modelica.Units.SI.MassFlowRate flueGasOffFlowRate = flueGasMinFlowRate/100 "Flue gas flow rate with GT switched off";
    parameter Modelica.Units.SI.MassFlowRate fuelNomFlowRate=12.1 "Nominal fuel flow rate";
    parameter Modelica.Units.SI.MassFlowRate fuelIntFlowRate=7.08 "Intermediate fuel flow rate";
    parameter Modelica.Units.SI.MassFlowRate fuelMinFlowRate=4.58 "Minimum fuel flow rate";
    parameter Modelica.Units.SI.MassFlowRate fuelOffFlowRate=0.1 "Fuel flow rate with GT switched off";
    parameter Real constTempLoad=0.60 "Fraction of load from which the temperature is kept constant";
    parameter Real intLoad=0.42 "Intermediate load for fuel consumption computations";
    parameter Modelica.Units.SI.Temperature flueGasNomTemp=843 "Maximum flue gas temperature";
    parameter Modelica.Units.SI.Temperature flueGasMinTemp=548 "Minimum flue gas temperature (zero electrical load)";
    parameter Modelica.Units.SI.Temperature flueGasOffTemp=363.15 "Flue gas temperature with GT switched off";

    // External inputs for fuel LHV and HHV
    Modelica.Blocks.Interfaces.RealInput LHV "Fuel Lower Heating Value [J/kg]"
      annotation (Placement(transformation(extent={{-120,60},{-100,80}})));
    Modelica.Blocks.Interfaces.RealInput HHV "Fuel Higher Heating Value [J/kg]"
      annotation (Placement(transformation(extent={{-120,30},{-100,50}})));
    Modelica.Blocks.Interfaces.RealOutput fuelFlowRateOut "Requested fuel mass flow rate [kg/s]"
      annotation (Placement(transformation(extent={{100,-20},{120,0}})));


    FlueGasMedium.BaseProperties gas;
    Modelica.Units.SI.MassFlowRate w;
    Modelica.Units.SI.Power P_el = noEvent(if GTLoad > 0 then GTLoad * maxPower else 0) "Electrical power output";
    Modelica.Units.SI.MassFlowRate fuelFlowRate "Fuel flow rate";

  equation
    gas.p = flueGasOut.p;
    gas.Xi = FlueGasMedium.reference_X[1:FlueGasMedium.nXi];

    gas.T = noEvent(
      if GTLoad > constTempLoad then flueGasNomTemp
      else if GTLoad > 0 then flueGasMinTemp + GTLoad / constTempLoad * (flueGasNomTemp - flueGasMinTemp)
      else flueGasMinTemp * (1 + GTLoad) - flueGasOffTemp * GTLoad);

    w = noEvent(
      if GTLoad > constTempLoad then flueGasMinFlowRate + (GTLoad - constTempLoad)/(1 - constTempLoad)*(flueGasNomFlowRate - flueGasMinFlowRate)
      else if GTLoad > 0 then flueGasMinFlowRate
      else flueGasMinFlowRate * (1 + GTLoad) - flueGasOffFlowRate * GTLoad);

    fuelFlowRate = noEvent(
      if GTLoad > intLoad then fuelIntFlowRate + (GTLoad - intLoad)/(1 - intLoad)*(fuelNomFlowRate - fuelIntFlowRate)
      else if GTLoad > 0 then fuelMinFlowRate + GTLoad/intLoad*(fuelIntFlowRate - fuelMinFlowRate)
      else fuelMinFlowRate * (1 + GTLoad) - fuelOffFlowRate * GTLoad);

    fuelFlowRateOut = fuelFlowRate;

    flueGasOut.m_flow = -w;
    flueGasOut.h_outflow = gas.h;
    flueGasOut.Xi_outflow = gas.Xi;

    annotation (Diagram(graphics));
  end TurboGas;

  model H2_Buffer
    Modelica.Blocks.Interfaces.RealInput mass_flow_in
      annotation (Placement(transformation(extent={{-140,30},{-100,70}}),
          iconTransformation(extent={{-140,30},{-100,70}})));
    Modelica.Blocks.Interfaces.RealOutput mass_flow_out
      annotation (Placement(transformation(extent={{100,-22},{130,8}}),
          iconTransformation(extent={{100,-22},{130,8}})));
    parameter Real stock = 0;

    Real Content(start=0) "Amount of mass stored in the buffer";

  equation
      // Mass balance differential equation
    der(Content) = mass_flow_in - mass_flow_out;

    // Ensure mass_flow_out does not exceed the available content
    mass_flow_out = if Content > 0 then min((1-stock)*mass_flow_in, Content) else 0;

    annotation (Icon(graphics={
          Ellipse(
            extent={{-100,100},{100,50}},
            lineColor={28,108,200},
            fillColor={255,170,170},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-100,-50},{100,-100}},
            lineColor={28,108,200},
            fillColor={255,170,170},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,76},{100,-74}},
            lineColor={28,108,200},
            fillColor={255,170,170},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-52,32},{58,-24}},
            textColor={28,108,200},
            textStyle={TextStyle.Bold},
            textString="H2")}));
  end H2_Buffer;

  model Control_Room
    import Modelica.Blocks.Types.Extrapolation;
    import Modelica.Blocks.Sources.CombiTimeTable;

    parameter Real n_HTSE = 8;
    parameter Real manualTable[:, :] = fill(0.0, 2, 5);
    parameter Real n_Reactors = 1;

    // Inputs
    Modelica.Blocks.Interfaces.RealInput P_nuc(start=100e6) annotation(Placement(transformation(extent={{-140,60},{-100,100}})));
    Modelica.Blocks.Interfaces.RealInput P_turbine(start = 10e6) annotation(Placement(transformation(extent={{-140,20},{-100,60}})));
    Modelica.Blocks.Interfaces.RealInput P_HTSE( start =1e6) annotation(Placement(transformation(extent={{-140,-100},{-100,-60}})));

    // Outputs
    Modelica.Blocks.Interfaces.RealOutput setpoint_H2 annotation(Placement(transformation(extent={{100,30},{120,50}})));
    Modelica.Blocks.Interfaces.RealOutput mflow_tapSteam annotation(Placement(transformation(extent={{100,-50},{120,-30}})));
    Modelica.Blocks.Interfaces.RealOutput turbine_load annotation(Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealOutput fossil_fuel_demand annotation(Placement(transformation(extent={{100,-90},{120,-70}})));

    // Variables
    Real Energy_Excess(start=0);
    Real tap_Setpoint(start=0);
    Real ramped_HTSE;
    Real ramped_turbogas;
    Real total_fossil_fuel_demand;
    Real Demand;

    // Load CSV data
    CombiTimeTable loadProfile(
    tableOnFile = false,
    table = manualTable,
    columns = {2,3,4,5},
    timeScale = 3600,
    tableName = "",
    extrapolation = Modelica.Blocks.Types.Extrapolation.HoldLastPoint)
    annotation(Placement(transformation(extent={{-80,-20},{-60,0}})));




  equation
    // Output assignments from table
    ramped_HTSE              = loadProfile.y[1];
    ramped_turbogas          = loadProfile.y[2];
    Demand                   = loadProfile.y[3];
    total_fossil_fuel_demand = loadProfile.y[4];


    // GUI-visible outputs
    setpoint_H2          = ramped_HTSE / 10;
    turbine_load         = ramped_turbogas;
    fossil_fuel_demand   = total_fossil_fuel_demand;
    tap_Setpoint         = 2 * setpoint_H2;
    mflow_tapSteam       = max(0.001, tap_Setpoint);

    // Energy balance
    Energy_Excess        = n_Reactors * P_nuc + P_turbine - P_HTSE * n_HTSE - Demand*1e6;

    annotation(Dialog(enable=true,
      group="Manual paste of CSV data",
      __Dymola_editText=true),
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={Bitmap(extent={{
                -96,-102},{96,106}},
            imageSource="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88gc8408gM84Ac8084Ac8gE888kE88gc4E88gc84E8gc84Ac8k84Ac8gE8488k88gc4E88gc84E8gc84Ac8k84Ac8gE84c8w88gc4E88gc84E8gc84Ac8k84Ac8gE84c8kw4Yc4IsIAUMEcEEUsAAsMMkAI8MAUMIc8kE8Yc4YA8gc88880E84Yc8884Qc8kk884Ukk88c4YcAgc8888kA84Yc8884kc8kk888oMk84M4Yc8Ac8888kk84Yc8884Yc8kk8888wk84YMYc8gww04wkgw0UQw8wwYQ4sow0wwkkU4Yc8c8gcw0s8ks8go84cc4cc4s08ks8gs4wYc4M8gc8Y88kk84YI8884Yc8kY8888kk8sYc4YMgc88w8kg44YcsU84Yc8kko888og84MU4Yc8c888AkkgAwc8wc4Yc8kk8kc8ogAYYIQYc8w8888Qk8AAAw8o4Yc8kk88Q8wgAAEcs4c8gM888kwAAAAEoMY4sMgQwMs8EgAAE0gYQ0oc8884AAAAYwU0wYc8AAAI88kk0QUQ8kgAA8888kAAAAAQkgQoAAAAAYYAAAEQEgQMgAAAU88kkMAAAEEgAAQYkY4kc4oEwYEgEgAAAAEc88k88AAEkwIAAIgg0Y4IIgwwEoEk4AAAAM88w8wAIEkgAgAAkAAck8kUEAAkEkgoAAAYU0kw4oQkkgAAEAAAAYYAAAAAkAEEgEIAAYYwIk8YMMMgAAAUAUsMYMUUMYIIAMsAQgAYYEEU88c888AAAAQgAYYQkk84Yc8kgAAYAYYAMk84M888okIAAUoMYAUk84Yc4MgAUAsYYAUs84YM884YcMQ0YYI8Ac84Yc4YcIEQAMsMUE84Yc884Yc8k080YYoAU4Yc4Yc8IA4Yc0wk84Yc884Yc8s0MoQAsoA4Yc4Yc8gIAccUEUkwQc888Yc8wEcocU4kgI4c4Yc8gcoQcY0MY4og8888c8gUc48c408sgc4E88gc8408gs8YAcM084M8gE84c84E88gc4E88gc84E8gc84Ac8k84QMkE84c84E88gc4E88gc84E8gc84Ac8k84Ac8k84c84E88gc4E88gc84E8gc84Ac8k84Ac8w8888kE84Ic4I88gc88s8kE84Ic8884Ic8kw888gg88cc8cc8gc8888gg88cc8888cc8gg8//aAAwDAQACAAMAAAAQk88gc84c4c84AE8k88k88gc84c884E4c8888gIc4Ac4Ac4ME8g08oU8kk88088kk84c88w8Qc4Ac4Ac4ck8gE84E8kk88k88kk84c84k8gc4Ac4Ac4ck8gE84E8kk88k88kk84c84c88c4Ac4Ac4ck8gE84E8kk88k88kk84c84c88w84c4sgEQYAcIEUYgIkgAskA8wAQYAQk88AM4c4cc4AE8k88sU8gc84c88QE4c888088gc8c4c84AE8k88kY8gc84c88ok4c888k88gc884c84kE8k88k8coc84c884c4c888k8sgc84Mc84Ag8g08o48wU88Q880EwY884s84s884c884AEsQ4AAoAcsgAUgE0AE8gAA4AcsE84c4M4AE8w88k88gco4c884E4co88k88gc4Yc4c8AE8ks8k8wgc8oc884E4c8o8k8wsc8sc4c88E8k88k44Acc40c84E4c880M8MEwU4c4c84A8k88w8oAcgQcI84E4c888g8oEgAMc4c84AAk84oIMIUgEss8IEYUoQcUcsEgAYYskU8AE888sgAAMc4sY40E884AUs8woYYocYcgEkM8w8koAAcgQ8gUUAAE4AE4Ack0YYAU8gEk48k8k8IAcgEIgE4UwAYwoU4wYwUYAAIgEk4Ak8888kcgE8wM4QAEY0A8MQQwwYAAc4Ek4AI88w8oogE8gUYAUg0MEEsQ4MMYMUcgck4Ackck8gkkE8gE4EAEwAE4AcEAA4gA0gAM4AcgEUU8cMI8gE4AkEsMU0MMAMcYMMocE0YAcgA0Mcw84coE4AAA4AE4U8gc84c4cgEgMAcgAA88gM4c88UIAEsQs0AYgc84c4MgAkoUcgAEE8gc8c884EY4sck80c4c84c4c4M0cAoc0088gc88884E4csUg4c8kc84c4c84E40Ug0I88gc84M84E4QwY8sA0sgc4c4c84AQAssIcgIsU84c84E4I880kA4gAUYc4c84AE4YcYw8Yock4c88E84Mc488g4c4gc4Ac4ME8gE8o080E8M088844c84c8gYc4Ac4Ac4ck8gE84E8kk88k88wAcc84c8gYc4Ac4Ac4ck8gE84E8kk88k88kk8884c8gYc4Ac4Ac4ck8gE84E8kk88k88kk4M88k88Qc8oc4Mc4AE8ks8kc8gs84c88ok4c88g88gc88c8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",
            fileName="modelica://sette_laghi/CR_img.jpg")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
  end Control_Room;

  model H2plant
    parameter Real N_HTSE;
    parameter Integer N_boiler;
    parameter Modelica.Units.SI.Power HeatSource_W=2.e6 "Thermal power to the boiler";

    parameter Integer NoP_boiler = 100 "Number of pipes in the external steam HX";
    parameter Modelica.Units.SI.Length L_boiler = 10 "Length of external steam HX pipes";
    parameter Modelica.Units.SI.Diameter D_boiler = 0.04 "Diameter of external steam HX pipes";
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
      annotation (Placement(transformation(extent={{-88,-64},{-60,-38}})));
    ThermoSysPro.Thermal.BoundaryConditions.HeatSource fuel(
      T0=fill(600, N_boiler),
      W0=fill(HeatSource_W/N_boiler, N_boiler),
      option_temperature=2)
      annotation (Placement(transformation(extent={{-12,20},{8,40}})));
    ThermoSysPro.InstrumentationAndControl.AdaptorForFMU.AdaptorModelicaTSP
      adaptorModelicaTSP
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={0,66})));
    Modelica.Blocks.Math.Gain gain(k=N_HTSE)
      annotation (Placement(transformation(extent={{52,-2},{72,18}})));
    Modelica.Blocks.Math.Gain gain1(k=1)
      annotation (Placement(transformation(extent={{-74,-10},{-54,10}})));
    Modelica.Blocks.Interfaces.RealInput H2_plant_setpoint
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Math.Gain gain2(k=1/N_HTSE)
      annotation (Placement(transformation(extent={{-54,64},{-34,84}})));
    Modelica.Blocks.Interfaces.RealInput H2_plant_Heat_Input annotation (
        Placement(transformation(
          extent={{20,-20},{-20,20}},
          rotation=90,
          origin={0,120})));
    Modelica.Blocks.Interfaces.RealOutput H2_plant_output annotation (Placement(
          transformation(extent={{100,-20},{140,20}}), iconTransformation(extent={
              {100,-20},{140,20}})));
  equation
    connect(fixVol.terminal,hTSE_module. term_n) annotation (Line(points={{-60,-51},
            {-60,-52},{-32,-52},{-32,-40},{-22,-40}},           color={0,120,120}));
    connect(fuel.C,hTSE_module. extHeat)
      annotation (Line(points={{-2,20.2},{-2,0},{2,0},{2,-8}},
                                                    color={0,0,0}));
    connect(adaptorModelicaTSP.outputReal,fuel. ISignal) annotation (Line(
          points={{0,55},{0,46},{-2,46},{-2,35}},                       color={
            0,0,255}));
    connect(H2_plant_setpoint, gain1.u)
      annotation (Line(points={{-120,0},{-76,0}}, color={0,0,127}));
    connect(gain1.y, hTSE_module.H2_target) annotation (Line(points={{-53,0},{-42,
            0},{-42,-14},{-21.2,-14}}, color={0,0,127}));
    connect(gain2.u, H2_plant_Heat_Input) annotation (Line(points={{-56,74},{-62,74},
            {-62,96},{0,96},{0,120}}, color={0,0,127}));
    connect(gain2.y, adaptorModelicaTSP.u)
      annotation (Line(points={{-33,74},{0,74},{0,78}}, color={0,0,127}));
    connect(hTSE_module.H2_production, gain.u)
      annotation (Line(points={{24.4,-14},{24.4,8},{50,8}}, color={0,0,127}));
    connect(gain.y, H2_plant_output)
      annotation (Line(points={{73,8},{82,8},{82,0},{120,0}}, color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
  end H2plant;

  model FossilConsumptionEval
    parameter Real efficiency = 0.8; //fattore che tiene conto di efficienza dei generatori termici e di perdite di sistema
    parameter Boolean demand = true;
    Real LHV_value;
    Modelica.Blocks.Interfaces.RealInput power_demand
      annotation (Placement(transformation(extent={{-140,-20},{-100,22}})));
    Modelica.Blocks.Interfaces.RealInput mass_flow_rate_required
      annotation (Placement(transformation(extent={{100,-20},{140,22}}),
          iconTransformation(extent={{100,-20},{140,22}})));
    Modelica.Blocks.Interfaces.RealInput LHV annotation (Placement(transformation(
          extent={{-20,-21},{20,21}},
          rotation=90,
          origin={0,-121})));

  equation
    LHV_value = max(50e6, LHV); //J/kg
    mass_flow_rate_required = if demand then power_demand  / (LHV_value*efficiency) else 0;
    annotation (Icon(graphics={Rectangle(
            extent={{-100,40},{100,-40}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid), Rectangle(
            extent={{-40,-40},{40,-100}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid)}));
  end FossilConsumptionEval;
  annotation (uses(
      ThermoPower(version="3.2"),
      Modelica(version="4.0.0"),
      ThermoSysPro(version="4.0"),
      Buildings(version="11.0.0")));
end sette_laghi;
