package com.harpia.HarpiaHealthAnalysisWS.business.concretes.bloodresult;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.bloodresult.BloodResultParseService;
import com.harpia.HarpiaHealthAnalysisWS.model.bloodresult.BloodResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class BloodResultParseManager implements BloodResultParseService {

    private static CustomLog log = new CustomLog(BloodResultParseManager.class);

    @Override
    public List<BloodResult> parseToDaily(List<BloodResult> list) {
        return getSelectedDataToShow(list, 20);
    }
//    public List<BloodResult> parseToDaily(List<BloodResult> list) {return getSelectedDataToShow(list, 10);}

    @Override
    public List<BloodResult> parseToWeekly(List<BloodResult> list) {
        return getSelectedDataToShow(list, 60*2);
    }

    @Override
    public List<BloodResult> parseToMonthly(List<BloodResult> list) {
        return getSelectedDataToShow(list, 60 * 6);
    }

    /**
     * parse to Six Month Data to Daily, Weekly or Monthly
     */
    private List<BloodResult> parseToRequestedTime(List<BloodResult> bloodResultList, LocalDateTime lastDate) {
        List<BloodResult> newBloodResultList = new ArrayList<>();
        LocalDateTime now = LocalDateTime.now();
        for (int i = 0; i < bloodResultList.size(); i++) {
            if (bloodResultList.get(i).getCreatedAt().isBefore(now) &&
                    bloodResultList.get(i).getCreatedAt().isAfter(lastDate)) {
                newBloodResultList.add(bloodResultList.get(i));
            } else {
                break;
            }

        }
        return newBloodResultList;
    }

    /**
     * For daily tmpMinute will be 10 which means minumum per 10 min saved data will be seen
     * For weekly tmpMinute will be 60 which means minumum per 60 min saved data will be seen
     * For month tmpMinute will be (60 * 4)  which means minumum per 240 min saved data will be seen
     */
    private List<BloodResult> getSelectedDataToShow(List<BloodResult> list, int tmpMinute) {
        List<List<BloodResult>> brGroupList = new ArrayList<>();
        List<BloodResult> brGroup = new ArrayList<>();
        List<BloodResult> selectedData = new ArrayList<>();
        int counterTimeMinus = 1;
        LocalDateTime startTime = LocalDateTime.now();
        LocalDateTime endTime = LocalDateTime.now().minusMinutes(tmpMinute * counterTimeMinus);
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getCreatedAt().isEqual(startTime) ||
                    list.get(i).getCreatedAt().isBefore(startTime) &&
                            list.get(i).getCreatedAt().isAfter(endTime)
            ) {
                brGroup.add(list.get(i));
                if (i == list.size() - 1) {
                    brGroupList.add(brGroup);
                }
            } else {
                i--;
                counterTimeMinus++;
                if (brGroup.size() > 0) {
                    brGroupList.add(brGroup);
                    brGroup = new ArrayList<>();
                }
                startTime = endTime;
                endTime = startTime.minusMinutes(tmpMinute);
            }
        }
        brGroupList.forEach(group -> {
            if (group.size() > 0) {
                selectedData.add(group.get(0));
            }
        });
        return selectedData;
    }

}
