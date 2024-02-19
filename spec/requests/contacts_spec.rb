require 'rails_helper'

RSpec.describe Contact, type: :request do
  describe 'GET /index' do
    let!(:contact) { create(:contact) }

    it 'returns correct http status' do
      get contacts_url

      expect(response).to have_http_status(:ok)
    end

    it 'renders correct template' do
      get '/contacts'

      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    let!(:contact) { create(:contact) }

    it 'returns a successful response' do
      get contact_url(contact) # /contacts/:id

      expect(response).to be_successful
    end

    it 'renders correct template' do
      get contact_url(contact)

      expect(response).to render_template(:show)
    end
  end

  describe 'GET /new' do
    it 'returns a successful response' do
      get new_contact_url

      expect(response).to be_successful
    end

    it 'renders correct template' do
      get '/contacts/new'

      expect(response).to render_template(:new)
    end
  end

  describe 'GET /edit' do
    let!(:contact) { create(:contact) }

    it 'returns a successful response' do
      get edit_contact_url(contact) # /contacts/:id/edit

      expect(response).to be_successful
    end

    it 'renders correct template' do
      get edit_contact_url(contact)

      expect(response).to render_template(:edit)
    end
  end

  describe 'POST /create' do
    context 'with valid params' do
      let(:params) { { first_name: 'Jane', last_name: 'Doe' } }

      it 'creates a new a contact' do
        expect {
          post('/contacts', params: { contact: params })
        }.to change(Contact, :count).by(1) #Contact.count 
      end

      it 'redirects to the created contact' do
        post contacts_url, params: { contact: params }

        expect(response).to redirect_to(contact_url(Contact.last))
      end
    end

    context 'with invalid params' do
      let(:params) { { first_name: 'Jane' } }

      it 'does not create a new a contact' do
        expect {
          post('/contacts', params: { contact: params })
        }.not_to change(Contact, :count)
      end

      it 'renders correct http status' do
        post contacts_url, params: { contact: params }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders correct template' do
        post contacts_url, params: { contact: params }
  
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH /update' do
    let!(:contact) { create(:contact) }

    context 'with valid params' do
      let(:params) { { first_name: 'Jane' } }

      it 'updates a new a contact' do
        expect {
          patch contact_url(contact), params: { contact: params }
        }.to change { contact.reload.first_name }.to('Jane')
      end

      it 'redirects to the contact' do
        patch contact_url(contact), params: { contact: params }

        expect(response).to redirect_to(contact_url(contact))
      end
    end

    context 'with invalid params' do
      let(:params) { { first_name: '' } }

      it 'does not update the contact' do
        expect {
          patch contact_url(contact), params: { contact: params }
        }.not_to change{ contact.reload.first_name }
      end

      it 'renders correct http status' do
        patch contact_url(contact), params: { contact: params }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders correct template' do
        patch contact_url(contact), params: { contact: params }
  
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:contact) { create(:contact) }

    it 'destroys the requested contact' do
      expect {
        delete contact_url(contact)
      }.to change(Contact, :count).by(-1)
    end

    it 'redirects to the correct url' do
      delete contact_url(contact)

      expect(response).to redirect_to(root_url)
    end
  end
end