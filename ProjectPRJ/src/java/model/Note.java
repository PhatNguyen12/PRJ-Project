package model;

import java.time.LocalDateTime;

public class Note {
    private int id;
    private String title;
    private String note;
    private int userId;
    private LocalDateTime createDate;
    private LocalDateTime modifiedDate;

    public Note() {
    }
    
    
    public Note(String titleString, String note, int userId) {
        this.title = titleString;
        this.note = note;
        this.userId = userId;
        this.createDate = LocalDateTime.now();
        this.modifiedDate = LocalDateTime.now();
    }

    public LocalDateTime getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(LocalDateTime modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public LocalDateTime getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDateTime createDate) {
        this.createDate = createDate;
    }
}
