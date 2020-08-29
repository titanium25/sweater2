package com.example.sweater.controller;

import com.example.sweater.domain.Message;
import com.example.sweater.domain.User;
import com.example.sweater.repos.MessageRepo;
import com.example.sweater.service.S3Services;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.util.Set;
import java.util.UUID;

@Controller
public class MessageController {

    @Autowired
    private MessageRepo messageRepo;

    @Autowired
    private S3Services s3Services;

    @Value("${gkz.s3.bucket}")
    private String bucket;

    @GetMapping("/user-messages/{user}")
    public String userMessages(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            Model model,
            @RequestParam(required = false) Message message
    ){
        Set<Message> messages = user.getMessages();

        model.addAttribute("messages", messages);
        model.addAttribute("message", message);
        model.addAttribute("isCurrentUser", currentUser.equals(user));

        return "userMessages";
    }

    @PostMapping("/user-messages/{user}")
    public String updateMessage(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long user,
            @RequestParam("id") Message message,
            @RequestParam("text") String text,
            @RequestParam("tag") String tag,
            @RequestParam("file") MultipartFile file
            ) {
        if(message.getAuthor().equals(currentUser) || currentUser.isAdmin()){
            if(!StringUtils.isEmpty(text)) {
                message.setText(text);
            }
            if(!StringUtils.isEmpty(tag) || currentUser.isAdmin()) {
                message.setTag(tag);
            }
            messageRepo.save(message);
        }

        saveFile(message, file, s3Services, bucket);

        return "redirect:/user-messages/" + user;
    }

    @GetMapping("/deleteMessage/{id}")
    public String deleteMessage(
            @PathVariable Long id
    ){
            messageRepo.deleteById(id);
        return "redirect:/main";
    }

    static void saveFile(@RequestParam("id") Message message,
                         @RequestParam("file") MultipartFile file,
                         S3Services s3Services,
                         String bucket) {
        if (file != null && !file.getOriginalFilename().isEmpty()) {

            String uuidFile = UUID.randomUUID().toString();
            String resultFileName = uuidFile + "." + file.getOriginalFilename();
            s3Services.uploadFile(resultFileName, file);
            message.setFilename("https://" + bucket + ".s3.eu-central-1.amazonaws.com/" + resultFileName);
        }
    }

}
