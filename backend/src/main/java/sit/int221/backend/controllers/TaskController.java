package sit.int221.backend.controllers;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import sit.int221.backend.dtos.AddEditTaskDTO;
import sit.int221.backend.dtos.AllTaskDTO;
import sit.int221.backend.entities.Task;
import sit.int221.backend.services.ListMapper;
import sit.int221.backend.services.TaskService;
import org.springframework.web.bind.annotation.CrossOrigin;

import java.util.List;

@RestController
@CrossOrigin(origins = "http://ip23us3.sit.kmutt.ac.th")
@RequestMapping("/v1/tasks")
public class TaskController {
    @Autowired
    private TaskService service;
    @Autowired
    ModelMapper modelMapper;
    @Autowired
    ListMapper listMapper;

    @GetMapping("")
    public List<AllTaskDTO> getAllTasks() {
        return service.getAllTasks();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Object> getTaskById(@PathVariable Integer id) {
        Task task = service.getTaskById(id);
        return ResponseEntity.ok(task);
    }

    @PostMapping("")
    public AddEditTaskDTO addNewTask(@RequestBody Task task) {
    return service.createNewTask(task);
    }

    @PutMapping("/{id}")
    public AddEditTaskDTO updateTask(@PathVariable Integer id, @RequestBody Task task) {
        return service.updateTask(id, task);
    }

}
