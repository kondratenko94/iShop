package com.springapp.mvc.service;

import com.springapp.mvc.criteria.CriteriaOption;
import com.springapp.mvc.criteria.QueryFilter;
import com.springapp.mvc.criteria.mobile.MobileCriteria;
import com.springapp.mvc.dao.MobileDao;
import com.springapp.mvc.exception.database.ConstraintException;
import com.springapp.mvc.model.Image;
import com.springapp.mvc.model.Mobile;
import com.springapp.mvc.storage.StorageService;
import com.springapp.mvc.dto.PaginationWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;

@Service
public class MobileServiceImpl implements MobileService  {

    private final int IMG_MAX_COUNT = Image.CAPACITY;
    private final String PRODUCT_TYPE = Mobile.TYPE;

    private MobileDao mobileDao;

    private StorageService storageService;

    @Autowired
    public void setMobileDao(MobileDao mobileDao) {
        this.mobileDao = mobileDao;
    }

    @Autowired
    public void setStorageService(StorageService storageService) {
        this.storageService = storageService;
    }

    @Override
    @Transactional
    public Integer addMobile(Mobile mobile) throws ConstraintException{

        int i = 0;
        for (Image image : mobile.getImages()) {
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

            image.setProduct(mobile);
        }
        mobile.setType(Mobile.TYPE);
        mobile.updatePreview();

        this.mobileDao.addMobile(mobile);

        return mobile.getId();
    }

    @Override
    @Transactional
    public void removeMobile(int id) {
        this.mobileDao.removeMobile(id);
    }

    @Override
    @Transactional
    public Mobile getMobileById(int id) {
        return this.mobileDao.getMobileById(id);
    }

    @Override
    @Transactional
    public void updateMobile(Mobile mobile) throws ConstraintException {

        Integer id = mobile.getId();

        if (id != null) {
            Mobile currentMobile = this.mobileDao.getMobileById( id );
            currentMobile.consumeMobile(mobile);

            int i = 0;
            for (Image image : mobile.getImages()) {
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

                for (Image attachedImage : currentMobile.getImages()) {

                    if (attachedImage.getId() == image.getId()) {

                        attachedImage.setLink( image.getLink() );
                        attachedImage.setPosition(image.getPosition());

                        break;
                    }

                }
            }
            currentMobile.updatePreview();

            this.mobileDao.updateMobile(currentMobile);
        }
    }

    @Override
    @Transactional
    public List<Mobile> listMobilesByIds(List<Integer> idList) {
        return this.mobileDao.listMobilesByIds(idList);
    }

    @Override
    @Transactional
    public PaginationWrapper<Mobile> listMobilesFiltered(MobileCriteria mobileCriteria, String sortMode, Integer page, int count) {

        QueryFilter mobileFilter = mobileCriteria.createMobileFilter();

        long matches = this.mobileDao.numberOfMatchesFiltered(mobileFilter);
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
        List<Mobile> mobiles = this.mobileDao.listMobilesFiltered(mobileFilter, sort, offset, count);

        PaginationWrapper<Mobile> pagWrapper = new PaginationWrapper<>();
        pagWrapper.setList(mobiles);
        pagWrapper.setCount(count);
        pagWrapper.setMaxCount(matches);

        return pagWrapper;
    }

    @Override
    @Transactional
    public List<CriteriaOption> createCriteriaOptions() {

        List<CriteriaOption> options = MobileCriteria.createCriteriaOptions();
        this.mobileDao.fillOptions(options);

        return options;
    }

}
