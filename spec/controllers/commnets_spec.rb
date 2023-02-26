RSpec.describe CommentsController, type: :controller do
  describe 'POST /create' do
    shared_examples 'correct behaviour' do
      let!(:project) { create(:project) }
      context 'with correct params' do
        it 'create comment' do
          expect do
            post :create, params: { project_id: project.id, comment: { text: 'test comment' } }
          end.to change(project.comments, :count).by(1).and(change(project.activities, :count).by(1))
          expect(response).to have_http_status(:redirect)
        end
      end
      context 'with incorrect params' do
        it 'fails' do
          expect do
            post :create, params: { project_id: project.id, comment: { text: '' } }
          end.to_not change(project.comments, :count)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
    context 'when user has admin role' do
      login_admin!
      it_behaves_like 'correct behaviour'
    end
    context 'when user has not admin role' do
      context 'moderator' do
        login_moderator!
        it_behaves_like 'correct behaviour'
      end
      context 'normal user' do
        login_user!
        it_behaves_like 'correct behaviour'
      end
    end
  end

  describe 'DELETE /destroy' do
    let!(:project) { create(:project) }
    let!(:comment) { create(:comment, project:) }
    context 'when user has admin role' do
      login_admin!
      it 'delete comment' do
        expect do
          delete :destroy, params: { project_id: project.id, id: comment.id }
        end.to change(Comment, :count).by(-1)
        expect(response).to have_http_status(:redirect)
      end
    end
    context 'when user has not admin role' do
      shared_examples 'restricted access' do |_code|
        it 'not delete comment' do
          expect do
            delete :destroy, params: { project_id: project.id, id: comment.id }
          end.to_not change(Comment, :count)
          expect(response).to have_http_status(:redirect)
        end
      end
      context 'moderator' do
        login_moderator!
        it_behaves_like 'restricted access'
      end
      context 'normal user' do
        login_user!
        it_behaves_like 'restricted access'
      end
    end
  end
end
