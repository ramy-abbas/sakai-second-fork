<%-- $Id$
include file for delivering multiple choice questions
should be included in file importing DeliveryMessages
--%>
<!--
<%--
***********************************************************************************
*
* Copyright (c) 2004, 2005, 2006 The Sakai Foundation.
*
* Licensed under the Educational Community License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*      http://www.osedu.org/licenses/ECL-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License. 
*
**********************************************************************************/
--%>
-->
<h:outputText value="<fieldset>" escape="false"/>
<h:outputText value="#{question.text}" escape="false">
  <f:converter converterId="org.sakaiproject.tool.assessment.jsf.convert.SecureContentWrapper" />
</h:outputText>
  <!-- ATTACHMENTS -->
  <%@ include file="/jsf/delivery/item/attachment.jsp" %>

  <t:dataTable value="#{question.selectionArray}" var="selection" width="100%">
    <t:column rendered="#{delivery.feedback eq 'true' &&
       delivery.feedbackComponent.showCorrectResponse && !delivery.noFeedback=='true'}" styleClass="feedBackMultipleChoice">
      <h:panelGroup id="image"
        rendered="#{selection.answer.isCorrect eq 'true' && selection.response}"
        styleClass="si si-check-lg">
      </h:panelGroup>
      <h:panelGroup id="image2"
        rendered="#{selection.answer.isCorrect != null && !selection.answer.isCorrect && selection.response}"
        styleClass="si si-remove feedBackCross">
      </h:panelGroup>
    </t:column>
    <t:column>
      <h:selectBooleanCheckbox id="samigo-mc-mc" value="#{selection.response}"
        disabled="#{delivery.actionString=='reviewAssessment' || delivery.actionString=='gradeAssessment'}" />
      <h:panelGroup layout="block" styleClass="mcAnswerText">
        <span class="samigo-answer-label strong" aria-hidden="true">
          <h:outputText value=" #{selection.answer.label}" escape="false" />
          <h:outputText value="#{deliveryMessages.dot} " rendered="#{selection.answer.label ne ''}" />
        </span>
        <h:outputLabel for="samigo-mc-mc" value="#{selection.answer.text}" escape="false">
          <f:converter converterId="org.sakaiproject.tool.assessment.jsf.convert.SecureContentWrapper" />
        </h:outputLabel>
      </h:panelGroup>
    </t:column>
    <t:column>
      <h:panelGroup rendered="#{delivery.feedback eq 'true' &&
       delivery.feedbackComponent.showSelectionLevel &&
	   selection.answer.generalAnswerFeedback != 'null' && selection.answer.generalAnswerFeedback != null && selection.answer.generalAnswerFeedback != ''&& selection.response}" > 
	   <!-- The above != 'null' is for SAK-5475. Once it gets fixed, we can remove this condition -->
       <f:verbatim><br /></f:verbatim>
       <h:outputText value="#{commonMessages.feedback}#{deliveryMessages.column} " />
       <h:outputText value="#{selection.answer.generalAnswerFeedback}" escape="false" />
      </h:panelGroup>
    </t:column>
  </t:dataTable>

<f:verbatim><br /></f:verbatim>
<h:panelGroup rendered="#{(delivery.actionString=='previewAssessment'
                || delivery.actionString=='takeAssessment' 
                || delivery.actionString=='takeAssessmentViaUrl')
             && delivery.navigation ne '1' && delivery.displayMardForReview }">
<h:selectBooleanCheckbox value="#{question.review}" id="mark_for_review" />
	<h:outputLabel for="mark_for_review" value="#{deliveryMessages.mark}" />
	<h:outputLink title="#{assessmentSettingsMessages.whats_this_link}" value="#" onclick="javascript:window.open('/samigo-app/jsf/author/markForReviewPopUp.faces','MarkForReview','width=350,height=280,scrollbars=yes, resizable=yes');event.preventDefault();" >
		<h:outputText  value=" #{assessmentSettingsMessages.whats_this_link}"/>
	</h:outputLink>
</h:panelGroup>

  <h:panelGroup rendered="#{question.itemData.hasRationale}" >
    <f:verbatim><br /><br /></f:verbatim>
    <h:outputLabel for="rationale" value="#{deliveryMessages.rationale}" />
    <f:verbatim><br /></f:verbatim>
    <h:inputTextarea id="rationale" value="#{question.rationale}" rows="5" cols="40" 
        rendered="#{delivery.actionString!='reviewAssessment' 
                 && delivery.actionString!='gradeAssessment'}" />
    <h:outputText id="rationale2" value="#{question.rationaleForDisplay}" 
        rendered="#{delivery.actionString=='reviewAssessment'
                 || delivery.actionString=='gradeAssessment'}" escape="false"/>
  </h:panelGroup>

<h:panelGroup rendered="#{delivery.feedback eq 'true'}">
  <h:panelGrid rendered="#{delivery.feedbackComponent.showCorrectResponse && !delivery.noFeedback=='true'}" >
    <h:panelGroup>
      <h:outputLabel for="answerKeyMC" styleClass="answerkeyFeedbackCommentLabel" value="#{deliveryMessages.ans_key}#{deliveryMessages.column} " />
      <h:outputText id="answerKeyMC" value="#{question.key}" escape="false" />
    </h:panelGroup>
    <h:outputText value=" "/>
  </h:panelGrid>

  <h:panelGrid rendered="#{delivery.feedbackComponent.showItemLevel && !delivery.noFeedback=='true' && question.feedbackIsNotEmpty}">
    <h:panelGroup>
      <h:outputLabel for="feedSC" styleClass="answerkeyFeedbackCommentLabel" value="#{commonMessages.feedback}#{deliveryMessages.column} " />
      <h:outputText id="feedSC" value="#{question.feedback}" escape="false" />
    </h:panelGroup>
    <h:outputText value=" "/>
  </h:panelGrid>

  <h:panelGrid rendered="#{delivery.actionString !='gradeAssessment' && delivery.feedbackComponent.showGraderComment && !delivery.noFeedback=='true' && (question.gradingCommentIsNotEmpty || question.hasItemGradingAttachment)}" columns="1" border="0">
    <h:panelGroup>
      <h:outputLabel for="commentSC" styleClass="answerkeyFeedbackCommentLabel" value="#{deliveryMessages.comment}#{deliveryMessages.column} " />
      <h:outputText id="commentSC" value="#{question.gradingComment}" escape="false" rendered="#{question.gradingCommentIsNotEmpty}"/>
    </h:panelGroup>
    
	<h:panelGroup rendered="#{question.hasItemGradingAttachment}">
      <h:dataTable value="#{question.itemGradingAttachmentList}" var="attach">
        <h:column>
          <%@ include file="/jsf/shared/mimeicon.jsp" %>
        </h:column>
        <h:column>
          <f:verbatim>&nbsp;&nbsp;&nbsp;&nbsp;</f:verbatim>
          <h:outputLink value="#{attach.location}" target="new_window">
            <h:outputText value="#{attach.filename}" />
          </h:outputLink>
        </h:column>
        <h:column>
          <f:verbatim>&nbsp;&nbsp;&nbsp;&nbsp;</f:verbatim>
          <h:outputText escape="false" value="(#{attach.fileSize} #{generalMessages.kb})" rendered="#{!attach.isLink}"/>
        </h:column>
      </h:dataTable>
    </h:panelGroup>
  </h:panelGrid>
</h:panelGroup>

<h:outputText value="</fieldset>" escape="false"/>
