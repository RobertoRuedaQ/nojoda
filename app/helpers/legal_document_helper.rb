module LegalDocumentHelper

  def new_amendment_status(application)
    if application.application_case == 'add_disbursement_modeling'
      content_tag :th, scope: 'col' do
        I18n.t('general.status')
      end
    end
  end

  def new_amendment_disbursement_status(application, disbursement)
    if application.application_case == 'add_disbursement_modeling'
      content_tag :th, scope: 'col' do
        I18n.t("disbursement.#{disbursement.status}")
      end
    end
  end

  def disbursement_value(application, disbursement)
    if application.application_case == 'add_disbursement_modeling'
      disbursement.adjusted_student_value
    else
      disbursement.student_value
    end
  end

  def scanned_document(legal_match)
    legal_match.scanned_document.attached? ? link_to(I18n.t('list.document') ,legal_match.scanned_document) : I18n.t('list.no_records')
  end
end