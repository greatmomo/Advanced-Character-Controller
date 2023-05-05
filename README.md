# Advanced Character Controller

The purpose of this project is to have a place to test character controller mechanics with a clean state machine.
This allows repurposing of a generalized controller for various projects with minor tweaks.

Default controls are as follows:
- Movement  -	WASD
- Jump      - Spacebar (release cancels jump)
- Dash		  -	Left Ctrl
- Glide		  -	Hold Spacebar (after last air jump)
- Options   - Hold Tab

Adjustable features include:
- Movement (speed, acceleration, friction)
- Jumping (jump height, gravity)
- Multi-Jump (double jump or more possible)
- Coyote Time
- Jump Buffering
- Wall Jump (adjustable slow-fall)
- Dash (time and velocity)
- Glide (fall and move speed)

Controller also includes sprite squishing to visually sell jump movement.

Thanks to GDQuest for boilerplate state machine code.
