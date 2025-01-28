# StarTS  

**StarTS** is a proof-of-concept engine implementation of Starcraft RTS gameplay, created using **Godot 4**.  
This project focuses on reverse engineering and reimagining the core mechanics of Starcraft within an open-source environment.  

⚠️ **Important:** StarTS is currently in **early development** and serves more as a **proof of concept** than a fully playable game.  

## Features  

### What’s Implemented  

Please take a look into the [GitHub project](https://github.com/users/andreas-volz/projects/1) for StarTS to see what's implemented and what not.

- **Godot Resource Import Process**:  
  Successfully imports Starcraft’s proprietary data formats into Godot, making them accessible for the engine.
  
- **Data Viewer** ("DatViewer"):  
  A viewer tool with similar functionality to the popular **DatEdit**, allowing exploration of the imported Starcraft data.  
  Note: The focus is only on viewing data, not editing it.  

![DatViewer](https://github.com/user-attachments/assets/da77c583-02bd-429b-8430-35ab7bdb995c)

- **Early Game Implementation**:  
  - Can load maps from Starcraft data files.
  - Place units on the map
  - Show wireframes
  - Show portrait videos
  - Play unit ready sounds
  - Units can walk on the terrain with basic terrain navigation.  

![StarTS](https://github.com/user-attachments/assets/9bb45c53-9d63-47d4-b4d5-0c77e723789a)

### What’s Missing  

- No real gameplay
- No attacking, no unit collisions 
- No resource gathering, base building, or AI.
- No network

## Repository  

The project repository is available on GitHub:  
[https://github.com/andreas-volz/starts](https://github.com/andreas-volz/starts)  

## License  

This project is licensed under the **GNU General Public License v3.0 (GPL-3)**.  
For more details, see the [LICENSE](https://www.gnu.org/licenses/gpl-3.0.html) file.  

## Related Project  

**[StarTSConverter](https://github.com/andreas-volz/startsconverter)**:  
A companion tool for exporting proprietary Starcraft data formats into open formats. All data has to be converter with it before importing in StarTS!

## Run
The process is still very raw:
> Open project in Godot 4
> Open UI/ResourceGenerator.tscn and run this scene
> Change path to StarTSConverter exported resources (or change in ResourceGenerator.gd)
> Press 'Generate' (and wait some seconds)

1. Start DatViewer:
> Open DatViewer/DatViewer.tscn and run this scene

2. Start the Game:
> Start the main Scene (which is in Game.tscn)

If you’re interested in Starcraft reverse engineering or contributing to the development of StarTS, this project is a great starting point! Stay tuned for future updates.  
