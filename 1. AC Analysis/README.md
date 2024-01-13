# AC Analysis of the Filters

On a planet where there is an increase in the supply and demand for alternative energy sources, such as wind and solar, problems arise with the injection of harmonics into the electrical grid outputs from these sources. 
Simply "combining" the two can lead to issues related to energy quality, synchronization with the electrical grid, fault detection, and proper and safe operation of the static power converter.
This gives rise to the need for a filter, such as L, LC and LCL that performs this function of harmonics surpession.

## The L Filter
To become familiar with the problem and the tools, the first step is to explore a simple circuit with an inductor. 
Since circuit simulators, such as PSIM, face difficulties in modeling inductors and capacitors without any associated resistance, the LR circuit was chosen to model the low-pass characteristic of the inductor, whose transfer function is: 
$$\frac{I_o}{V_i} = \frac{1}{sL + R}$$
You are able to check the schematic and the results of the simulation of this filter on the files "LR_AC" on the PSIM folder. 
If you want the analysis of the L filter, open the MATLAB folder and look for the "L" file, where you can plot the Bode Diagram of the filter and explore it.

## The LCL Filter
The L filter presents a significant main issue: it's attenuation. Because it has only one pole in its transfer function, it results in a decay of only 20dB per decade, which places it in an unfavorable middle ground of "pass or not pass" 
for certain frequencies. 
In other words, the main challenge in using this filter lies in achieving good attenuation at the switching frequency while allowing the passage of the grid frequency with not very high inductance values.
As an alternative, the LCL filter offers greater attenuation for higher-order harmonics, as well as lower circulation of reactive power through the system and better dynamic response. 
In addition to these factors, it has the advantage of being more easily used in high-power applications where high switching frequencies are employed. On the other hand, 
there are obstacles to implementing this third-order filter, with the main challenges being the increased number of measured variables, damping of resonance, and susceptibility to parametric uncertainties in the Power Converter (PAC). 
The transfer function of the filter can be seen below:
$$\ \frac{I_o}{V_i} = \frac{sR_fC_f + 1}{s^3C_fL_gL_t + s^2R_fC_f(L_g+L_t) + s(L_g + L_t)} \$$
The schematic of the filter is built on "LCL_AC" file on the PSIM folder where you are able to visualize the AC Analysis of the filter. On the 'LCL' file inside the MATLAB folder, 
you can visualize the Bode plot and use the function 'sisotool' to help develop the plant controller (it will be useful further). Other than that, you are able to vizualize the Bode Diagram of the plant without the passive damping, that means, without any resistor.
After the analysis, you should be able to visualize a higher in the LCL filter compared to the L filter, at 40 dB per decade. This lower decay is due to the value associated with the resistor, which reduces the resonance peak but decreases the signal attenuation by 20 dB per decade. 
If we simulate again, but with no resistence, we get the transfer function below 
$$\ \frac{I_o}{V_i} = \frac{1}{s^3C_fL_gL_t + s(L_g + L_t)} \$$
where it can be seen that there the zero no longer exists in the TF increasing the decay to 60dB per decade, and turning it unstable due to the lack of quadratic elements in the third order characteristic equation (Routh-Hurwitz criterion).




