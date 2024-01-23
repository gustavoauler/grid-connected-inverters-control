# Current Control of the Single-phase LCL filter
The first approach to the current control problem will be a single-phase grid connected to a controlled voltage source and a LCL filter, as it is illustrated in the image below:

  ![single_lcl](https://github.com/gustavoauler/grid-connected-inverters-control/assets/113851430/227fcbe4-3f52-40aa-acbc-0afda81a5302)

## Using the PI Controller
The conventional solution to this issue typically involves implementing a control block where the feedback signal is the grid current. This block incorporates a PI controller to eliminate the output error, with the controller's output serving as the control signal for the controlled voltage source. This method works, but only if the goal is to create a rectifier. By entering a step reference signal, the PI controller will track the reference, which is not sinusoidal, resulting in a continuous current on the grid. This can be seen in the PSIM simulation file located on the 'PI' folder named 'LCL_PI_const'.
To generate a sinusoidal current on the grid, it is necessary to create a sinusoidal reference. To do so, the reference signal is built by dividing the voltage signal by its amplitude, creating a unitary sinusoidal wave in phase with the voltage. After that, simply multiply this wave by the desired amplitude of the grid current. This signal connected to the previous control block will create another problem: The PI is not able to track the sinusoidal entrance, that is, it can not null the output error. This aspect can be seen on the PSIM file located on the 'PI' folder named 'LCL_PI_sin'. To solve this problem, it is necessary to add a ressonant controller, that will be detailed in the next section.
## Using the PR (Proportional-Ressonant) Controller
A resonant controller, often combined with a proportional element, earning its nickname as a PR (Proportional Resonant) controller, is a specific type of transfer function commonly implemented in closed-loop control systems exhibiting sinusoidal behavior.
In the context of power electronics, proportional resonant controllers hold significant importance in AC current or voltage controllers due to their performance and straightforward implementation.
In DC applications, PI and PID controllers can provide optimal performance, showcasing zero steady-state error due to their infinite DC gain provided by the integrator in the transfer function. However, in AC applications, these controllers exhibit a delay in tracking their response, preventing zero steady-state error.
Proportional resonant controllers offer a finite yet very high gain at the desired AC frequency, possessing a disturbance rejection characteristic and consequently nullifying the steady-state error. The transfer function representing this controller is given by:
$$\ C(s) = K_p + \frac{K_rs}{s^2+\omega^2} \$$
In this expression, the term in the denominator $s^2+\omega^2\$ creates an infinite control gain at the frequency $\omega$.
To design this controller, the following block diagram can represent the transfer function described above:
![image](https://github.com/gustavoauler/grid-connected-inverters-control/assets/113851430/ffc495bb-a47a-4877-b2d4-4163a73a6796)
The choice of the optimal constant parameters mainly rely on empirical methods, but a good starting point for the LCL filter plant described in this section is:
$$\ K_p = \frac{L_1+\frac{L_2}{1 - \omega^2 L_2 C}}{\tau_c} \ $$
where the proportional constant is the inductance divided by the time constant of the controller, determined by the designer.
The other constant is determined using the gain $G_c$ at the ressonant frequency $\omega_c$:
$$\ G_c = \frac{K_r \omega_c}{\omega_c^2 + \omega^2} \$$
In the LCL filter,  $\omega_c$ is 
$$\ \omega_c = \sqrt{\frac{L_1 + L_2}{L_1L_2C}} \$$ 
thus, $K_r$ will have its final expression given by, where the gain is set to 0.1
$$\ K_r= 0.1\frac{\omega_c^2 + \omega^2}{\omega_c} \$$
It is crucial to emphasize that these values provide an initial estimation of the parameters. Therefore, iterative testing is essential for controller tuning to achieve optimal performance. In the conducted tests, which varied the individual inductance from 20µH to 1mH (values within the typical range chosen for LCL filters), all yielded satisfactory results.
To tune the controller, it is important to understand what the variation of the constant parameters mean. By varying the parameters $K_p$ and $K_r$, it is possible to optimize the controller. As mentioned earlier, the proportional gain $K_p$ primarily determines the controller's dynamics, while Kr determines the amplitude gain at a selected frequency and controls the bandwidth around it. This relationship can be observed in the following graphs, where one of the controller values is kept constant while the other is varied, displayed in multiple curves on the same graph:
![image](https://github.com/gustavoauler/grid-connected-inverters-control/assets/113851430/3be273c2-a048-49d3-ac41-0d013c1cfda0)
![image](https://github.com/gustavoauler/grid-connected-inverters-control/assets/113851430/afccf4fd-b79f-4b1a-a598-1fd723bee45a)
The PR folder contains two simulations: The 'LCL_PR_Auto' file contains a simulation where you can modify the inductors and capacitor of the filter, inside the 'FILE' block, and it will generate the controller parameters based on the equations described previouly. The 'LCL_PR_Manual' contains a simulation where the constant parameter can be modified inside the 'FILE' block, so the controller can be tunned.

