package com.springapp.mvc.service;

import com.springapp.mvc.criteria.CriteriaOption;
import com.springapp.mvc.criteria.QueryFilter;
import com.springapp.mvc.criteria.notebook.NotebookCriteria;
import com.springapp.mvc.dao.NotebookDao;
import com.springapp.mvc.dto.NotebookDto;
import com.springapp.mvc.dto.PaginationWrapper;
import com.springapp.mvc.exception.database.ConstraintException;
import com.springapp.mvc.model.Image;
import com.springapp.mvc.model.Notebook;
import com.springapp.mvc.storage.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class NotebookServiceImpl implements NotebookService{

    private final int IMG_MAX_COUNT = Image.CAPACITY;
    private final String PRODUCT_TYPE = Notebook.TYPE;

    @Autowired
    private NotebookDao notebookDao;

    @Autowired
    private StorageService storageService;

    @Override
    @Transactional
    public Integer addNotebook(Notebook notebook) throws ConstraintException{

        int i = 0;
        for (Image image : notebook.getImages()) {
            if (i++ >= IMG_MAX_COUNT) break;

            String filePath = "";

            MultipartFile file = image.getFile();
            String source = image.getSource();

            if (file != null && !file.isEmpty()) {
                filePath = storageService.saveFile(file, PRODUCT_TYPE);

            } else if (source!= null && !source.isEmpty()) {
                filePath = storageService.saveFromUrl(source, PRODUCT_TYPE);
            }

            if (!filePath.equals("")) {
                image.setLink(filePath);
            } else {
                image.setLink("");
            }
            image.setProduct(notebook);
        }
        notebook.setType(Notebook.TYPE);
        notebook.updatePreview();

        this.notebookDao.addNotebook(notebook);

        return notebook.getId();

    }

    @Override
    @Transactional
    public void removeNotebook(int id) {
        this.notebookDao.removeNotebook(id);
    }

    @Override
    @Transactional
    public Notebook getNotebookById(int id) {
        return this.notebookDao.getNotebookById(id);
    }

    @Override
    @Transactional
    public Integer updateNotebook(Notebook notebook) throws ConstraintException{
        Integer id = notebook.getId();

        if (id != null) {
            Notebook currentNotebook = this.notebookDao.getNotebookById( id );
            currentNotebook.consumeNotebook(notebook);

            int i = 0;
            for (Image image : notebook.getImages()) {
                if (i++ >= IMG_MAX_COUNT) break;

                String filePath = "";

                MultipartFile file = image.getFile();
                Integer position = image.getPosition();

                if (position != null) {

                    if (file != null && !file.isEmpty()) {
                        filePath = storageService.saveFile(file, PRODUCT_TYPE);

                        if (!filePath.equals("")) {
                            image.setLink(filePath);
                        }
                    }
                }


                for (Image attachedImage : currentNotebook.getImages()) {

                    if (attachedImage.getId() == image.getId()) {

                        attachedImage.setLink( image.getLink() );
                        attachedImage.setPosition(image.getPosition());

                        break;
                    }

                }
            }
            currentNotebook.updatePreview();

            this.notebookDao.updateNotebook(currentNotebook);
        }

        return id;
    }

    @Override
    @Transactional
    public List<Notebook> listNotebooksByIds(List<Integer> idList) {
        return this.notebookDao.listNotebooksByIds(idList);
    }

    @Override
    @Transactional
    public PaginationWrapper<Notebook> listNotebooksFiltered(NotebookCriteria criteria, String sortMode, Integer page, int count) {

        QueryFilter notebookFilter = criteria.createNotebookFilter();

        long matches = this.notebookDao.numberOfMatchesFiltered(notebookFilter);
        long pagesCount = (long) Math.ceil( (float)matches / (float)count );
        if (page == null || page < 1 || page > pagesCount) {
            page = 1;
        }
        int offset = (page - 1) * count;

        String sort;
        switch (sortMode) {
            case "1" : sort = " order by id desc"; break;
            case "2" : sort = " order by name asc"; break;
            case "3" : sort = " order by name desc"; break;
            case "4" : sort = " order by price asc"; break;
            case "5" : sort = " order by price desc"; break;
            default: sort = "";
        }
        List<Notebook> notebooks = this.notebookDao.listNotebooksFiltered(notebookFilter, sort, offset, count);

        PaginationWrapper<Notebook> pagWrapper = new PaginationWrapper<>();
        pagWrapper.setList(notebooks);
        pagWrapper.setCount(count);
        pagWrapper.setMaxCount(matches);

        return pagWrapper;
    }

    @Override
    @Transactional
    public List<CriteriaOption> createCriteriaOptions() {
        List<CriteriaOption> options = NotebookCriteria.createCriteriaOptions();
        this.notebookDao.fillOptions(options);
        return options;
    }

}