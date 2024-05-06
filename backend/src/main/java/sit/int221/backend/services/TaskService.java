package sit.int221.backend.services;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.HttpClientErrorException;
import sit.int221.backend.dtos.AddEditTaskDTO;
import sit.int221.backend.dtos.AllTaskDTO;
import sit.int221.backend.entities.Task;
import sit.int221.backend.exceptions.ItemNotFoundException;
import sit.int221.backend.repositories.TaskRepository;

import java.util.List;


@Service
public class TaskService {
    @Autowired
    private TaskRepository repository;
    @Autowired
    ModelMapper modelMapper;
    @Autowired
    ListMapper listMapper;

    public List<AllTaskDTO> getAllTasks() {
        return listMapper.mapList(repository.findAll(), AllTaskDTO.class, modelMapper);
    }


    public Task getTaskById(Integer id) {
        return repository.findById(id).orElseThrow(
                () -> new ItemNotFoundException( "Task id " + id + " dose not exist !!!"){

                }
        );
    }

    @Transactional
    public AddEditTaskDTO createNewTask(Task task) {
        return modelMapper.map(repository.save(task), AddEditTaskDTO.class);
    }

    @Transactional
    public AllTaskDTO removeTask(Integer id) {
        Task task = repository.findById(id).orElseThrow(
                () -> new ItemNotFoundException("NOT FOUND")
        );
        repository.delete(task);
        return modelMapper.map(task, AllTaskDTO.class);
    }


    @Transactional
    public AddEditTaskDTO updateTask(Integer id, Task task) {
        if (task.getId() != null) {
            if (!task.getId().equals(id)) {
                throw new HttpClientErrorException(HttpStatus.BAD_REQUEST,
                        "Conflict id !!! (" + id + " vs " + task.getId() + ")");
            }
        }

        Task existngTask = repository.findById(id).orElseThrow(
                () -> new HttpClientErrorException(HttpStatus.NOT_FOUND,
                        "Task id " + id + " dose not exist !!!"));

        existngTask.setTitle(task.getTitle());
        existngTask.setDescription(task.getDescription());
        existngTask.setAssignees(task.getAssignees());
        existngTask.setStatus(task.getStatus());

        return modelMapper.map(repository.save(existngTask), AddEditTaskDTO.class);
    }
}
